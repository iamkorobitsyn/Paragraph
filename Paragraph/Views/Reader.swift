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
    @State private var pageContent: [TextLine] = []
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    
    var body: some View {
        
        let interval = textService.getInterval()
        let padding = textService.getPadding()
        let font = textService.getFont()
        let uIFont = textService.getUIFont()
        
        if presented {
            GeometryReader { geometry in
                Color(.clear)
                    .onAppear()
                { contentUpdate(content: testBook, geometry: geometry, uiFont: uIFont) }
                    .onChange(of: textService.getSize())
                { contentUpdate(content: testBook, geometry: geometry, uiFont: uIFont) }
                    .onChange(of: textService.getUIFont())
                { contentUpdate(content: testBook, geometry: geometry, uiFont: uIFont) }
                    .onChange(of: textService.getInterval())
                { contentUpdate(content: testBook, geometry: geometry, uiFont: uIFont) }
                    .onChange(of: textService.getPadding())
                { contentUpdate(content: testBook, geometry: geometry, uiFont: uIFont) }
                
                ZStack(alignment: .top) {
                    Color(colorService.theme().background)
                        .ignoresSafeArea()
                    
                    HStack() {
                        Text("Цирк семьи пайло")
                            .foregroundStyle(Color.gray)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], textService.getPadding())
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
                                
                                ForEach(0..<pageContent.count, id: \.self) { index in
                                    TextLineView(font: font,
                                                 fontColor: colorService.theme().text,
                                                 wordsList: pageContent[index].text,
                                                 interval: interval,
                                                 padding: padding)
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
    
    private func contentUpdate(content: Book, geometry: GeometryProxy, uiFont: UIFont) {
        pageContent = []
        
        textService.setPaddingList(device: device)
        let padding = textService.getPadding() * 2
        let maxWidht = geometry.size.width - padding
        
        
        let maxHeight = geometry.size.height - 100
        var tempHeight: CGFloat = 0
        let interval = textService.getInterval()
        
       
        
        textService.updateProgress(content: content)
        
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, maxWidth: maxWidht, font: uiFont)
            if maxHeight < tempHeight + wordsLine.textHight { break }
            pageContent.append(wordsLine)
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
    
    var body: some View {
        HStack() {
            ForEach(Array(wordsList.enumerated()), id: \.offset) {i, word in
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
        }
        .padding([.leading, .trailing], padding)
    }
}

#Preview {
    ReaderView(device: .phone, presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
