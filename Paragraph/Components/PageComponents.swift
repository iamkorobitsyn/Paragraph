//
//  PageComponents.swift
//  Paragraph
//
//  Created by Александр Коробицын on 24.09.2025.
//

import Foundation
import SwiftUI

//struct TopMarginLine: View {
//    
//    let width: CGFloat
//    
//    var body: some View {
//        Rectangle().fill(.black)
//            .frame(width: width, height: 4)
//            .cornerRadius(2)
//            .padding(.top, 60)
//    }
//}

//struct TopBoundsDetection: View {
//    
//    var verticalDetection: (Bool) -> Void
//    
//    var body: some View {
//        LazyVStack {
//            Rectangle().fill(.clear)
//                .frame(height: 1)
//                .onAppear() { verticalDetection(false) }
//                .onDisappear() { verticalDetection(true) }
//        }
//    }
//}
//
//struct BottomBoundsDetection: View {
//    
//    var verticalDetection: (Bool) -> Void
//    
//    var body: some View {
//        LazyVStack {
//            Rectangle().fill(.clear)
//                .frame(height: 1)
//                .onAppear() { verticalDetection(false) }
//                .onDisappear() { verticalDetection(true) }
//        }
//    }
//}

//struct StaticPartChangerView: View {
//    
//    @State private var reverseIs: Bool = false
//    
//    enum Mode {
//        case previous
//        case next
//        case combined
//    }
//    
//    let screenHeght: CGFloat
//    let backgroundColor: Color
//    let previousTextContent: AnyView?
//    let currentTextContent: AnyView?
//    let nextTextContent: AnyView?
//
//    let updateReverse: (Bool) -> Void
//    
//    var body: some View {
//        TabView(selection: .constant(1)) {
//            
//            if previousTextContent != nil {
//                ZStack {
//                    Color(Color.blue)
//                    ScrollView { previousTextContent }
//                }.tag(0).onAppear() {
//                    print(previousTextContent)
//                    reverseIs = true }
//            }
//                
//            
//            
//            ZStack {
//                Color(backgroundColor)
//                ScrollView { currentTextContent }
//                HStack {
//                    Rectangle().fill(Color.customGold).frame(width: 6, height: 200)
//                        .cornerRadius(3)
//                        .padding(.bottom, 120)
//                    Spacer()
//                    Rectangle().fill(Color.customGold).frame(width: 6, height: 200)
//                        .cornerRadius(3)
//                        .padding(.bottom, 120)
//                }
//            }.tag(1)
//                .onDisappear() { if reverseIs {updateReverse(true)} else {updateReverse(false)} }
//            
//            ZStack {
//                Color(backgroundColor)
//                ScrollView { nextTextContent }
//            }.tag(2).onAppear() { reverseIs = false }
//            
//        }
//        .frame(height: screenHeght)
//        .tabViewStyle(.page)
//    }
//    
//}
//
//struct DynamicPartChangerView: View {
//    
//    let scroll: Bool
//    let previousPart: Bool
//    let tabDisabled: Bool
//    
//    let backgroundColor: Color
//    let textContent: AnyView
//    let screenHeght: CGFloat
//    
//    let updateContent: () -> Void
//    
//    
//    var body: some View {
//        VStack {
//            TabView(selection: .constant(previousPart ? 1 : 0)) {
//                
//                if previousPart {
//                    ZStack {
//                        Color(backgroundColor)
//                        ScrollView { textContent }
//                    }
//                    
//                    HStack {
//                        Rectangle().fill(Color.customGold)
//                        
//                            .opacity(tabDisabled ? 0 : 1)
//                            .frame(width: 10, height: 200)
//                            .cornerRadius(5)
//                            .padding(.bottom, 120)
//                        Spacer()
//                    }
//                        .onDisappear() {
//                            print("Reverse")
//                            updateContent() }
//                    
//                } else {
//                    HStack {
//                        Spacer()
//                        Rectangle().fill(Color.customGold)
//                        
//                            .opacity(tabDisabled ? 0 : 1)
//                            .frame(width: 10, height: 200)
//                            .cornerRadius(5)
//                    }.tag(0)
//                        .onDisappear() {
//                            print("notReverse")
//                            updateContent() }
//                    ZStack {
//                        Color(backgroundColor)
//                        ScrollView { textContent }.padding(.top, 60)
//                    }
//                }
//            }
//            .frame(height: screenHeght)
//            .tabViewStyle(.page)
//            .disabled(tabDisabled)
//            
//        }
//    }
//}

//MARK: - TextLineView

struct TextLineView: View {
    
    let font: Font
    let textColor: Color
    let textLine: TextLine
    let interval: CGFloat
    let padding: CGFloat
    
    var body: some View {
        
        HStack(spacing: 0) {
            if textLine.startFlag && textLine.mode == .paragraph {
                Rectangle().fill(.clear)
                    .frame(width: 20, height: 5)
            }
            
            
                ForEach(Array(textLine.text.enumerated()), id: \.offset) { i, word in
                    
                    if textLine.endFlag {
     
                            WordView(i: word.id ?? nil, text: word.text, font: font, color: textColor, interval: interval)
                            if i != textLine.text.count - 1 || textLine.text.count == 1 { Spacer(minLength: 0) }
                            
                        } else {
                            if i != textLine.text.count - 1 || textLine.text.count == 1 {
                                WordView(i: word.id, text: word.text, font: font, color: textColor, interval: interval)
                                Spacer(minLength: 0)
                            } else {
                                WordView(i: word.id, text: word.text, font: font, color: textColor, interval: interval)
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
