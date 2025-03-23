//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    let content: Book = testBook
    
    @Binding var readerPresented: Bool
    @Binding var settingsPresented: Bool
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var wordsList: [String] = []
    @State private var maxLines: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            Color(.clear)
                .onAppear() { contentUpdate(geometry: geometry) }
                .onChange(of: textService.getSize()) { contentUpdate(geometry: geometry) }
                .onChange(of: textService.getUIFont()) { contentUpdate(geometry: geometry) }
            
            ZStack(alignment: .top) {
                
                Color(colorService.theme().background)
                    .ignoresSafeArea()
                
                HStack() {
                    Spacer()
                    Selector(mode: .readerControls) { i in
                        if i == 0 {
                            settingsPresented.toggle()
                        } else {
                            readerPresented.toggle()
                        }
                    }
                    .padding(.trailing, 20)
                }
                
                
                ZStack(alignment: .top) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<maxLines, id: \.self) { index in
                            TextLineView(font: textService.getFont(),
                                         fontColor: colorService.theme().text,
                                         wordsList: wordsList)
                        }
                        
                    }
                }
                .padding([.top, .bottom], 50)
                .padding([.leading, .trailing], 20)
            }
        }
    }
    
    private func contentUpdate(geometry: GeometryProxy) {
        maxLines = Int((geometry.size.height / 1.25) / textService.getSize())
        wordsList = textService.createWordList(text: testBook.text[2].words,
                                               maxWidth: geometry.size.width - 40,
                                               font: textService.getUIFont())
    }
}

struct TextLineView: View {
    
    let font: Font
    let fontColor: Color
    let wordsList: [String]
    
    var body: some View {
        HStack() {
            ForEach(wordsList, id: \.self) { word in
                Text(word)
                    .font(font)
                    .foregroundStyle(fontColor)
                    .lineLimit(1)
                    .background(.clear)
                    .multilineTextAlignment(word == wordsList.first ? .leading : .center)
                    .multilineTextAlignment(word == wordsList.last ? .trailing : .center)
                
                if word != wordsList.last {
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

#Preview {
    ReaderView(readerPresented: .constant(true), settingsPresented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
