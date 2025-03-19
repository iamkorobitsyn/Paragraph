//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @Binding var readerPresented: Bool
    
    let content: Book = testBook
    
    @AppStorage("fontSizeValue") private var fontSize: Double = 20.0
    
    @State private var wordsList: [String] = []

    @EnvironmentObject private var textService: TextService
    
    @State private var maxLines: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(.clear)
                        .border(Color.black)
                    
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
                    
                        .frame(width: geometry.size.width - 50,
                               height: geometry.size.height / 2)
                    
                    LazyVStack(spacing: 0) {
                        let linesCount = Int(maxLines)
                        
                        
                        ForEach(0..<linesCount, id: \.self) { index in
                            TextLineView(fontSize: CGFloat(fontSize), wordsList: wordsList)
                        }
                    }
                }.frame(width: geometry.size.width - 50,
                        height: geometry.size.height / 2)
                
                SettingsView(presented: .constant(true))
                
                Button(action: { readerPresented.toggle() }) {
                    Text("Close")
                        .foregroundColor(.red)
                        .font(.title)
                }
                .opacity(1)
            }
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
    ReaderView(readerPresented: .constant(true))
        .environmentObject(TextService())
}
