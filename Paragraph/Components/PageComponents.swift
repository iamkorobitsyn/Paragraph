//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
import SwiftUI

//MARK: - TextView

struct TextView: View {
    
    @EnvironmentObject private var textService: TextService
    
    let backColor: Color
    let textColor: Color
    
    let font: Font
    let interval: CGFloat
    let padding: CGFloat
    
    @Binding var prevPage: TextLinesPart
    @Binding var currentPage: TextLinesPart
    @Binding var nextPage: TextLinesPart
    
    let updateContent: (SwipeState) -> Void
    
    enum SwipeState { case previous, next }
    
    @State private var reverseIs: Bool = false
    @State private var selected: Int = 1
    
    @State private var plaiceholderOpacity: Double = 0
    @State private var tabDisabled: Bool = false
    @State private var topBoundsDetected: Bool = false
    @State private var bottomBoundsDetected: Bool = false
    
    
    
    @AppStorage("curr") private var currentId = 0
    
    
    var body: some View {
        GeometryReader { geometry in
 
            ZStack {
                
                //MARK: - LoaderPlaceholder
                
                TabView {
                    ZStack {
                        Color(backColor)
                        ScrollView { constructTextContent(currentPage.text) }
                        SwipeLinesView(lLine: topBoundsDetected, rLine: bottomBoundsDetected)
                    }
                }
                .tabViewStyle(.page)
                .disabled(true)
                .padding(.top, 1)
                .opacity(plaiceholderOpacity)
                
                if currentPage.height > geometry.size.height {
                    
                    //MARK: - DynamicScroll

                            
                    ScrollViewReader { proxy in
                        ScrollView {
                          
                            
                            ZStack {
                                
                                VStack(spacing: 0) {
                                    BoundsDetectionView { detected in topBoundsDetected = detected}
                                   
                                   VStack(spacing: 0) {
                                         ForEach(0..<currentPage.text.count, id: \.self) { index in
                                             if index == 0 { Rectangle().fill(.clear).frame(height: 20) }
                                             ZStack {
                                                 TextLineView(
                                                    font: font,
                                                    textColor: textColor,
                                                    textLine: currentPage.text[index],
                                                    interval: interval,
                                                    padding: padding
                                                 )
                                                 GeometryReader { geometry in Color.clear
                                                         .onChange(of: geometry.frame(in: .named("scroll")).minY) { oldValue, newValue in
                                                             if newValue >= 0 && newValue < 30 { currentId = index }
                                                             print(currentId)
                                                         }
                                                 }
                                             }
                                         }
                                     }
                                    
                                    BoundsDetectionView { detected in bottomBoundsDetected = detected}
                                }
                                .background(backColor)
                                
                                
                                if !prevPage.text.isEmpty {
                                    
                                    VStack {
                                        
                                        TabView(selection: $selected) {
                                            ZStack { ScrollView { constructTextContent(prevPage.text) } }
                                                .background(backColor)
                                                .tag(0)
                                            
                                            Color.clear.tag(1)
                                                .onDisappear() {
                                                    if topBoundsDetected && selected == 0 {
                                                        updateContent(.previous)
                                                        updateLoadingState()
                                                    }
                                                }
                                        }
                                        .tabViewStyle(.page(indexDisplayMode: .never))
                                        .disabled(topBoundsDetected ? false : true)
                                        Spacer()
                                    }
                                    .padding(.top, 1)
                                }
                                
                                if !nextPage.text.isEmpty {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        TabView(selection: $selected) {
            
                                            Color.clear.tag(1)
                                                .onDisappear() {
                                                    
                                                    if bottomBoundsDetected && selected == 2 {
                                                        updateContent(.next)
                                                        updateLoadingState()
                                                    }
                                                }
                                            
                                            ZStack { ScrollView { constructTextContent(nextPage.text) } }
                                                .background(backColor)
                                                .tag(2)
                                        }
                                        .tabViewStyle(.page(indexDisplayMode: .never))
                                        .disabled(bottomBoundsDetected ? false : true)
                                    }
                                    .padding(.top, 1)
                                }
                            }
                        }
                        .onAppear { proxy.scrollTo(currentId, anchor: .top) }
                    }
   
                    SwipeLinesView(lLine: topBoundsDetected && !prevPage.text.isEmpty,
                                   rLine: bottomBoundsDetected && !nextPage.text.isEmpty)

                } else {
                    //MARK: - StaticTab
                    
                    ScrollView {
                        
                        ZStack {
                            
                            VStack {
                                constructTextContent(currentPage.text).background(backColor)
                                Spacer()
                            }
                            
                            VStack {
                                TabView(selection: $selected) {
                                    
                                    if !prevPage.text.isEmpty {
                                        ScrollView { constructTextContent(prevPage.text) }.background(backColor).tag(0)
                                    }
                                    
                                    Color.clear.tag(1)
                                        .onDisappear() {
                                            if selected == 0 {updateContent(.previous)}
                                            if selected == 2 {updateContent(.next)}
                                            updateLoadingState()
                                        }
                                    
                                    if !nextPage.text.isEmpty {
                                        ScrollView { constructTextContent(nextPage.text) }.background(backColor).tag(2)
                                    }
                                }
                                .frame(height: geometry.size.height)
                                .tabViewStyle(.page(indexDisplayMode: .never))
                                .disabled(tabDisabled)
                                
                                Spacer()
                            }
                        }
                        .padding(.top, 1)
                    }
                    SwipeLinesView(lLine: !prevPage.text.isEmpty ? true : false, rLine: !nextPage.text.isEmpty ? true : false)
                }
            }
        }
    }
    
    //MARK: - UpdateLoadingState
    
    private func updateLoadingState() {
        plaiceholderOpacity = 1
        tabDisabled = true
        selected = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            tabDisabled = false
            plaiceholderOpacity = 0
        })
    }
    
  
    //MARK: - ConstructPageContent
    
    private func constructTextContent(_ lines: [TextLine]) -> some View {
       LazyVStack(spacing: 0) {
            ForEach(0..<lines.count, id: \.self) { index in
                if index == 0 { Rectangle().fill(.clear).frame(height: 20) }
                TextLineView(
                    font: font,
                    textColor: textColor,
                    textLine: lines[index],
                    interval: interval,
                    padding: padding
                )
            }
        }
    }
}

struct TopMarginLine: View {
    
    let width: CGFloat
    
    var body: some View {
        Rectangle().fill(.black)
            .frame(width: width, height: 3)
            .cornerRadius(3)
    }
}

//MARK: - VerticalBoundsDetection

struct BoundsDetectionView: View {
    
    let detected: (Bool) -> Void
    
    var body: some View {
        LazyVStack {
            Rectangle().fill(.clear)
                .frame(height: 1)
                .onAppear() { detected(true) }
                .onDisappear() { detected(false) }
        }
    }
}

struct SwipeLinesView: View {
    
    let lLine: Bool
    let rLine: Bool
    
    var body: some View {
        HStack {
            Rectangle().fill(.black).frame(width: 6, height: 200)
                .cornerRadius(6)
                .opacity(lLine ? 1 : 0)
                .padding(.leading, 6)
            Spacer()
            Rectangle().fill(.black).frame(width: 6, height: 200)
                .cornerRadius(6)
                .opacity(rLine ? 1 : 0)
                .padding(.trailing, 6)
        }
    }
}

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
                }
            }
    }
}

