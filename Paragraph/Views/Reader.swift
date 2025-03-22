//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @Binding var readerPresented: Bool
    @Binding var settingsPresented: Bool
    
    let content: Book = testBook
    
    @State private var wordsList: [String] = []

    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var maxLines: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            Color(colorService.theme().background)
                .ignoresSafeArea()
            
            HStack {
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
            
                .onAppear() {
                    maxLines = (geometry.size.height / 2.4) / textService.getSize()
                    wordsList = textService.createWordList(text: testBook.text[2].words,
                                                           maxWidth: geometry.size.width - 50,
                                                           font: textService.getUIFont()) }
                .onChange(of: textService.getSize()) {
                    maxLines = (geometry.size.height / 2.4) / textService.getSize()
                    wordsList = textService.createWordList(text: testBook.text[2].words,
                                                           maxWidth: geometry.size.width - 50,
                                                           font: textService.getUIFont())
                    print("work")
                }
            ZStack(alignment: .top) {
                    LazyVStack(spacing: 0) {
                        let linesCount = Int(maxLines)
                        
                        
                        ForEach(0..<linesCount, id: \.self) { index in
                            TextLineView(font: textService.getFont(),
                                         fontColor: colorService.theme().text,
                                         wordsList: wordsList)
                                
                        }
                    }
                    
            }.padding([.top, .bottom], 50)
                .padding([.leading, .trailing], 20)
            
           
            
            }
        
        
        
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
