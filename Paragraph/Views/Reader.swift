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
    
    @AppStorage("fontSizeValue") private var fontSize: Double = 20.0
    
    @State private var wordsList: [String] = []

    @EnvironmentObject private var textService: TextService
    
    @State private var maxLines: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            Color(.white)
                .ignoresSafeArea()
            
            HStack {
                Button(action: {readerPresented.toggle()}) {
                    Image("closeGray")
                }
                .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {settingsPresented.toggle()}) {
                    Image("settingsGray")
                }
                .padding(.trailing, 20)
            }
            
                .onAppear() {
                    maxLines = (geometry.size.height / 2.4) / fontSize
                    wordsList = textService.createWordList(text: testBook.text[2].words,
                                                           maxWidth: geometry.size.width - 50,
                                                           fontSize: fontSize) }
                .onChange(of: fontSize) {
                    maxLines = (geometry.size.height / 2.4) / fontSize
                    wordsList = textService.createWordList(text: testBook.text[2].words,
                                                           maxWidth: geometry.size.width - 50,
                                                           fontSize: fontSize)
                }
            ZStack(alignment: .top) {
//                Color(.blue)

                    LazyVStack(spacing: 0) {
                        let linesCount = Int(maxLines)
                        
                        
                        ForEach(0..<linesCount, id: \.self) { index in
                            TextLineView(fontSize: CGFloat(fontSize), wordsList: wordsList)
                                
                        }
                        
                    }
                    
            }.padding([.top, .bottom], 50)
                .padding([.leading, .trailing], 20)
            
            }
        
        
    }
}

struct TextLineView: View {
    
    let fontSize: CGFloat
    let wordsList: [String]
    
    var body: some View {
        HStack() {
            ForEach(wordsList, id: \.self) { word in
                Text(word)
                    .font(.system(size: fontSize))
                    .foregroundStyle(Color.customGray)
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
}
