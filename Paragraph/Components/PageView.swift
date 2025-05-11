//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
import SwiftUI

struct PageView: View {
    
    let font: Font
    let interval: CGFloat
    let padding: CGFloat
    
    let backgroundColor: Color
    let textColor: Color
    
    let previousPage: [TextLine]
    let currentPage: [TextLine]
    let nextPage: [TextLine]
    
    @State private var pageCounter = [0, 1, 2]
    @State private var selection = 1
    @State private var touchDisabled: Bool = true

    @State private var pageOffset: CGFloat = 0
    @State private var currentPageOpacity: CGFloat = 1
    
    @State private var fadingPage: [TextLine] = []
    @State private var fadingReverse: Bool = false
    
    @State private var tempPage: [TextLine] = []
    @State private var tempPageOpacity: CGFloat = 0

    let onPageTurn: (_ withReverse: Bool) -> Void
    
  
    var body: some View {
        
        ZStack {
            
            //MARK: - FadingPage
            
            GeometryReader { geometry in
                pageContent(fadingPage)
                    .opacity(calculateFading(isReversed: fadingReverse))
            }
            
            //MARK: - TempPage
            
            GeometryReader { geometry in
                pageContent(currentPage)
                    .opacity(tempPageOpacity)
            }
            
            //MARK: - TabView
            
            TabView(selection: $selection) {
                
                ForEach(pageCounter, id: \.self) { index in
                    GeometryReader { geometry in
                        
                        if index == 0 {
                            
                            Color(backgroundColor)
                            pageContent(previousPage)
                                .onAppear() {
                                    touchDisabled = true
                                }
                            
                        } else if index == 1 {
                            
                            Color(backgroundColor)
                                .opacity(currentPageOpacity)
                            
                            pageContent(currentPage)
                                .opacity(currentPageOpacity)
                            
                            //MARK: - Offset & Fading
                            
                                .onChange(of: geometry.frame(in: .global).minX) { oldValue, newValue in
                                    tempPageOpacity = 0
                                    let threshold = 0.01
                                    pageOffset = newValue
                                    if newValue > threshold {
                                        currentPageOpacity = 0
                                        fadingReverse = true
                                        fadingPage = currentPage
                                        
                                    } else if newValue < -threshold {
                                        currentPageOpacity = 1
                                        fadingReverse = false
                                        fadingPage = nextPage
                                        
                                    }
                                }
                            
                                .onAppear() {
                                    touchDisabled = true
                                    tempPageOpacity = 1
                                    if previousPage.isEmpty { pageCounter = [1, 2] }
                                    if nextPage.isEmpty { pageCounter = [0, 1] }
                                }
                            
                                .onDisappear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { touchDisabled = false }
                                    onPageTurn(fadingReverse)
                                    currentPageOpacity = 1
                                    selection = 1
                                }
                            
                        } else if index == 2 {
                            Color(.clear)
                                .onAppear() {
                                    touchDisabled = true
                                }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disabled(touchDisabled)
        }
        
        .onChange(of: previousPage.count) {
            tempPageOpacity = 1
            if previousPage.isEmpty && pageCounter.contains(0) {
                pageCounter.removeFirst()
            } else {
                if !pageCounter.contains(0) { pageCounter.insert(0, at: 0) }
            }
            
        }
        
        .onChange(of: nextPage.count) {
            tempPageOpacity = 1
            if nextPage.isEmpty && pageCounter.contains(2) {
                pageCounter.removeLast()
            } else {
                if !pageCounter.contains(2) { pageCounter.append(2) }
            }
        }
    }
    
    //MARK: - PageContent
    
    private func pageContent(_ lines: [TextLine]) -> some View {
        VStack(spacing: 0) {
            ForEach(0..<lines.count, id: \.self) { index in
                TextLineView(
                    font: font,
                    textColor: textColor,
                    textLine: lines[index],
                    interval: interval,
                    padding: padding,
                    endBlock: lines[index].isEndOfBlock,
                    endContent: lines[index].isEndOfContent
                )}
            Spacer()
        }
    }
    
    //MARK: - CalculateFading
    
    private func calculateFading(isReversed: Bool = false) -> Double {
        let screenWidth = UIScreen.main.bounds.width
        let normalizedOffset = abs(pageOffset / screenWidth)
        let rawOpacity = min(1, normalizedOffset)
        return isReversed ? (1 - rawOpacity) : rawOpacity
    }
}

//MARK: - TextLineView

struct TextLineView: View {
    
    let font: Font
    let textColor: Color
    let textLine: TextLine
    let interval: CGFloat
    let padding: CGFloat
    let endBlock: Bool
    let endContent: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            if textLine.isStartOfBlock && textLine.mode == .paragraph {
                Rectangle().fill(.clear)
                    .frame(width: 20, height: 5)
            }
            
                ForEach(Array(textLine.text.enumerated()), id: \.offset) { i, word in
                    
                        if !endBlock {
     
                            WordView(i: word.id ?? nil, text: word.text, font: font, color: textColor, interval: interval)
                            if i != textLine.text.count - 1 || textLine.text.count == 1 { Spacer(minLength: 0) }
                            
                        } else {
                            
                            WordView(i: word.id, text: word.text, font: font, color: textColor, interval: interval)
                            if i == textLine.text.count - 1 { Spacer(minLength: 0) }
                        }
                }
        }
        .padding([.leading, .trailing], padding)
    }
}

//MARK: - WordView

struct WordView: View {
    let i: Int?
    let text: String
    let font: Font
    let color: Color
    let interval: CGFloat
    
    @State private var isHighlighted: Bool = false
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(isHighlighted ? Color.white : color)
            .background(isHighlighted ? Color.blue : .clear)
            
            .lineLimit(1)
            .padding(.top, interval)
        
        
            .onTapGesture {
                if i != nil {
                    isHighlighted.toggle()
//                    print(i ?? "nil")
                }
            }
    }
}
