//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
import SwiftUI

struct PageView: View {
    @State private var selectedPage = 1
    @State private var pageOffset: CGFloat = 0
    @State private var tabViewOpacity: CGFloat = 1
    @State private var reversedOpacity: Bool = false
    
    let font: Font
    let interval: CGFloat
    let padding: CGFloat
    
    let backgroundColor: Color
    let textColor: Color
    
    let previousPage: [TextLine]
    let currentPage: [TextLine]
    let nextPage: [TextLine]
    
    let onPageTurn: (_ withReverse: Bool) -> Void
    
    var body: some View {
        
        let pages = [previousPage, currentPage, nextPage]
        
        Color(backgroundColor)

        ZStack() {
 
            LazyVStack(spacing: 0) {
                ForEach(0..<nextPage.count, id: \.self) { index in
                    TextLineView(font: font,
                                 textColor: textColor,
                                 textLine: nextPage[index],
                                 interval: interval,
                                 padding: padding,
                                 endBlock: nextPage[index].isEndOfBlock)
                }
            }
            .opacity(calculateOpacity(isReversed: reversedOpacity))
                
            TabView(selection: $selectedPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    GeometryReader { geometry in
                        if index == 1 {
                            
                            ZStack {
                                Color(backgroundColor)
                                   
                                    .opacity(tabViewOpacity)
                                    .onChange(of: geometry.frame(in: .global).minX) { oldValue, newValue in
                                        pageOffset = newValue
                                    }
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<currentPage.count, id: \.self) { index in
                                        TextLineView(font: font,
                                                     textColor: textColor,
                                                     textLine: currentPage[index],
                                                     interval: interval,
                                                     padding: padding,
                                                     endBlock: currentPage[index].isEndOfBlock)
                                    }
                                }
                                .opacity(tabViewOpacity)
                            }
                            .onDisappear() {
                                onPageTurn(false)
                            }
                            
                            
                        } else if index == 0 {
                            ZStack {
                                Color(backgroundColor)
                                 
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<currentPage.count, id: \.self) { index in
                                        TextLineView(font: font,
                                                     textColor: textColor,
                                                     textLine: currentPage[index],
                                                     interval: interval,
                                                     padding: padding,
                                                     endBlock: currentPage[index].isEndOfBlock)
                                    }
                                }
                                    .onChange(of: geometry.frame(in: .global).minX) {
                                        tabViewOpacity = 0
                                        reversedOpacity = true
                                    }
                                    .onDisappear() {
                                        tabViewOpacity = 1
                                        reversedOpacity = false
                                    }
                            }
                        }
                    }
                    .onDisappear {
                        selectedPage = 1
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    private func calculateOpacity(isReversed: Bool = false) -> Double {
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
    
    var body: some View {
        HStack(spacing: 0) {
            if textLine.isStartOfBlock && textLine.mode == .paragraph {
                Rectangle().fill(.clear)
                    .frame(width: 20)
            }
            
                ForEach(Array(textLine.text.enumerated()), id: \.offset) { i, word in
                        if !endBlock {
     
                            WordView(i: word.id, text: word.text, font: font, color: textColor, interval: interval)

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
    let i: Int
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
                isHighlighted.toggle()
                print(i)
            }
    }
}
