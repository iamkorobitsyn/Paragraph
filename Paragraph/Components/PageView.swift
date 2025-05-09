//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
import SwiftUI

struct PageView: View {
    
    @State private var pageOffset: CGFloat = 0
    @State private var frontPageOpacity: CGFloat = 1
    @State private var fadingReverse: Bool = false

    let font: Font
    let interval: CGFloat
    let padding: CGFloat
    
    let backgroundColor: Color
    let textColor: Color
    
    let previousPage: [TextLine]
    let currentPage: [TextLine]
    let nextPage: [TextLine]
    
    let onPageTurn: (_ withReverse: Bool) -> Void
    
    @State private var backgroundPage: [TextLine] = []
    @State private var selection = 1
    @State private var pages = [0, 1, 2]
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ForEach(0..<backgroundPage.count, id: \.self) { index in
                            TextLineView(font: font,
                                         textColor: textColor,
                                         textLine: backgroundPage[index],
                                         interval: interval,
                                         padding: padding,
                                         endBlock: backgroundPage[index].isEndOfBlock,
                                         endContent: backgroundPage[index].isEndOfContent)                        }
                        Spacer()
                    
                    }
                    .opacity(calculateFading(isReversed: fadingReverse))
            }
            
            TabView(selection: $selection) {
                
                ForEach(pages, id: \.self) { index in
                    GeometryReader { geometry in
                        
                        if index == 0 {
                            
                            Color(backgroundColor)
                            VStack(spacing: 0) {
                                ForEach(0..<previousPage.count, id: \.self) { index in
                                    TextLineView(font: font,
                                                 textColor: textColor,
                                                 textLine: previousPage[index],
                                                 interval: interval,
                                                 padding: padding,
                                                 endBlock: previousPage[index].isEndOfBlock,
                                                 endContent: previousPage[index].isEndOfContent)

                                }
                                Spacer()
                            }
                            
                        } else if index == 1 {
                            
                            Color(backgroundColor)
                                .opacity(frontPageOpacity)
                            VStack(spacing: 0) {
                                ForEach(0..<currentPage.count, id: \.self) { index in
                                    TextLineView(font: font,
                                                 textColor: textColor,
                                                 textLine: currentPage[index],
                                                 interval: interval,
                                                 padding: padding,
                                                 endBlock: currentPage[index].isEndOfBlock,
                                                 endContent: currentPage[index].isEndOfContent)
                                }
                                Spacer()
                            }
                            
                            .opacity(frontPageOpacity)
                            .onChange(of: geometry.frame(in: .global).minX) { oldValue, newValue in
                                let threshold = 0.01
                                pageOffset = newValue
                                if newValue > threshold {
                                    frontPageOpacity = 0
                                    fadingReverse = true
                                    backgroundPage = currentPage
                                    
                                } else if newValue < -threshold {
                                    frontPageOpacity = 1
                                    fadingReverse = false
                                    backgroundPage = nextPage
                                    
                                }
                            }
                            
                            .onAppear() {
                                
                                if previousPage.isEmpty {
                                    if pages.contains(0) {
                                        print("prev clean")
                                        pages.removeFirst()
                                    }
                                } else {
                                    if !pages.contains(0) {
                                        pages.insert(0, at: 0)
                                    }
                                }
                                
                                if nextPage.isEmpty {
                                    print("next clean")
                                    if pages.contains(2) {
                                        pages.removeLast()
                                    }
                                } else {
                                    if !pages.contains(2) {
                                        pages.append(2)
                                    }
                                }
                                
                            }
                            
                            .onDisappear() {
                                onPageTurn(fadingReverse)
                                frontPageOpacity = 1
                                selection = 1
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
        .onChange(of: previousPage.count) {
            print("Change")
            if previousPage.isEmpty {
                if pages.contains(0) {
                    print("prev clean")
                    pages.removeFirst()
                }
            } else {
                if !pages.contains(0) {
                    pages.insert(0, at: 0)
                }
            }
        }
        
        .onChange(of: nextPage.count) {
            print("Change")
            if nextPage.isEmpty {
                print("next clean")
                if pages.contains(2) {
                    pages.removeLast()
                }
            } else {
                if !pages.contains(2) {
                    pages.append(2)
                }
            }
        }
        
        
    }
    
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

                            if i != textLine.text.count - 1 || textLine.text.count == 1 {
                                Spacer(minLength: 0)
                            }
                            
                        } else {
                            
                            WordView(i: word.id, text: word.text, font: font, color: textColor, interval: interval)
                            
                            
                            if i == textLine.text.count - 1 {
                                Spacer(minLength: 0)
                            }
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
