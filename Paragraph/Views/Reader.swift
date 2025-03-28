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
    
    @State private var selectedText: String?
    @State private var globalFrame: CGPoint = .zero
    
    
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
                                                 textLine: textLines[index],
                                                  interval: interval,
                                                  padding: padding,
                                                 endBlock: textLines[index].isEndOfBlock,
                                                 globalFrame: $globalFrame)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            
                                .onChanged { value in
                                    print("work")
                                    globalFrame = value.location
                                }
                        )
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
    let textLine: TextLine
    let interval: CGFloat
    let padding: CGFloat
    let endBlock: Bool
    
    @Binding var globalFrame: CGPoint
    
    var body: some View {
        HStack(spacing: 0) {
            if textLine.isStartOfBlock && textLine.mode == .paragraph {
                Rectangle().fill(.clear)
                    .frame(width: 20)
            }
            
                ForEach(Array(textLine.text.enumerated()), id: \.offset) { i, word in
                        if !endBlock {
     
                            Word(text: word, font: font, color: fontColor, interval: interval, globalFrame: $globalFrame)
                                .multilineTextAlignment(word == textLine.text.first ? .leading : .center)
                                .multilineTextAlignment(word == textLine.text.last ? .trailing : .center)

                            if word != textLine.text.last || textLine.text.count == 1 {
                                Spacer(minLength: 0)
                            }
                            
                            
                            
                        } else {
                            Word(text: word, font: font, color: fontColor, interval: interval, globalFrame: $globalFrame)
                                .multilineTextAlignment(.leading)
                            
                            if word == textLine.text.last {
                                Spacer(minLength: 0)
                            }
                        }
                }
            
        }
        
        .padding([.leading, .trailing], padding)
    }
}

struct Word: View {
    let text: String
    let font: Font
    let color: Color
    let interval: CGFloat
    
    @State private var isHighlighted: Bool = false
    @Binding var globalFrame: CGPoint
    @State private var localFrame: CGRect = .zero
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(isHighlighted ? Color.white : color)
            .background(isHighlighted ? Color.blue : .clear)
            .cornerRadius(4)
            .lineLimit(1)
            .padding(.top, interval)
            .background(
                GeometryReader { geometry in
                    Color.clear.ignoresSafeArea()
                        .onAppear {
                            // Получаем фрейм в глобальных координатах
                            self.localFrame = geometry.frame(in: .global)
                        }
                        .onChange(of: geometry.frame(in: .global)) {
                            self.localFrame = geometry.frame(in: .global)
                        }
                }
            )
        
            .onTapGesture {
                isHighlighted.toggle()
            }

            .onChange(of: globalFrame) {
                let touchZone = localFrame.insetBy(dx: -50, dy: 0) // Добавляем зону допуска
                if touchZone.contains(globalFrame) {
                    isHighlighted = true
                }
            }
    }
}


#Preview {
    ReaderView(device: .phone, presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
