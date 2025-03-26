//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    let device: UIUserInterfaceIdiom
    
    let content: Book = testBook
    
    @State private var textLines: [TextLine] = []
    private enum Indent {
        case min, mid, max
    }
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    
    var body: some View {
        
        let font = textService.getFont()
        let uIFont = textService.getUIFont()
        
        let interval = textService.getInterval()
        let padding = textService.getPadding()
        
        let backgroundColor = colorService.theme().background
        let textColor = colorService.theme().text
        
        
        if presented {
            GeometryReader { geometry in
                Color(.clear)
                    .onAppear() {
                        contentUpdate(testBook, geometry, uIFont, interval, padding)
                    }
        
                    .onChange(of: font) {
                        contentUpdate(testBook, geometry, uIFont, interval, padding)
                    }
                
                    .onChange(of: [interval, padding]) {
                        contentUpdate(testBook, geometry, uIFont, interval, padding)
                    }

                
                ZStack(alignment: .top) {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    
                    HStack() {
                        Text("Цирк семьи пайло")
                            .foregroundStyle(Color.gray)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], padding)
                            .padding(.top, 20)
                    }
   
                    VStack() {
                        
                        HStack() {
                            
                            Spacer()
                            Selector(mode: .readerControls) { i in
                                if i == 0 {
                                    settingsPresented.toggle()
                                } else {
                                    presented.toggle()
                                    settingsPresented = false
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        .frame(height: 50)
                       
                        
                        ZStack(alignment: .top) {
                            LazyVStack(spacing: 0) {
                                
                                ForEach(0..<textLines.count, id: \.self) { index in
                                    TextLineView(font: font,
                                                 fontColor: textColor,
                                                 wordsList: textLines[index].text,
                                                 interval: interval,
                                                 padding: padding,
                                                 endBlock: textLines[index].isEndOfBlock)
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        Text("58 %")
                            .foregroundStyle(Color.gray)
                        .frame(height: 50)
                        .padding(.bottom, 10)
                    }
                    .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    SettingsView(presented: $settingsPresented)
                }
            }
        }
    }
    
    private func contentUpdate(_ content: Book,
                               _ geometry: GeometryProxy,
                               _ uIFont: UIFont,
                               _ interval: CGFloat,
                               _ padding: CGFloat) {
        print("update")
        textLines = []

        let maxWidht = geometry.size.width - padding * 2
        let maxHeight = geometry.size.height - 100
        
        var tempHeight: CGFloat = 0

        textService.updateProgress(content: content)
        
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, maxWidth: maxWidht, uIFont: uIFont)
            if maxHeight < tempHeight + wordsLine.textHight { break }
            textLines.append(wordsLine)
            tempHeight += wordsLine.textHight + interval
        }
    }
}

struct TextLineView: View {
    
    let font: Font
    let fontColor: Color
    let wordsList: [String]
    let interval: CGFloat
    let padding: CGFloat
    let endBlock: Bool
    
    var body: some View {
        HStack() {
            if !endBlock {
                ForEach(Array(wordsList.enumerated()), id: \.offset) { i, word in
                    Text(word)
                        .font(font)
                        .foregroundStyle(fontColor)
                        .lineLimit(1)
                        .background(.clear)
                        .multilineTextAlignment(word == wordsList.first ? .leading : .center)
                        .multilineTextAlignment(word == wordsList.last ? .trailing : .center)
                        .padding(.top, interval)
                    if word != wordsList.last {
                        Spacer(minLength: 0)
                    }
                }
            } else {
                ForEach(Array(wordsList.enumerated()), id: \.offset) { i, word in
                    Text(word)
                        .font(font)
                        .foregroundStyle(fontColor)
                        .lineLimit(1)
                        .background(.clear)
                        .multilineTextAlignment(word == wordsList.first ? .leading : .center)
                        .multilineTextAlignment(word == wordsList.last ? .trailing : .center)
                        .padding(.top, interval)
                }
            }
            
        }
        .padding([.leading, .trailing], padding)
    }
}

#Preview {
    ReaderView(device: .phone, presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
