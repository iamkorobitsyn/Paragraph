//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @State private var textLinesOfCurrentPage: [TextLine] = []
    @State private var textLinesOfNextPage: [TextLine] = []
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var firstBlockOfCurrentPage: Int = 0
    @State private var firstWordOfCurrentPage: Int = 0
    
    @State private var firstBlockOfNextPage: Int = 0
    @State private var firstWordOfNextPage: Int = 0
    
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
                        contentUpdate(textService.content, geometry, uIFont, interval, padding)
                    }
        
                    .onChange(of: font) {
                        contentUpdate(textService.content, geometry, uIFont, interval, padding)
                    }
                
                    .onChange(of: [interval, padding]) {
                        contentUpdate(textService.content, geometry, uIFont, interval, padding)
                    }
                
                
                
                ZStack(alignment: .top) {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    
                    PageView(font: font,
                             interval: interval,
                             padding: padding,
                             backgroundColor: backgroundColor,
                             textColor: textColor,
                             previousPage: textLinesOfCurrentPage,
                             currentPage: textLinesOfCurrentPage,
                             nextPage: textLinesOfNextPage) { withReverse in
                        firstBlockOfCurrentPage = firstBlockOfNextPage
                        firstWordOfCurrentPage = firstWordOfNextPage
                        contentUpdate(textService.content, geometry, uIFont, interval, padding)
                    }
                             .padding(.top, 60)
                            

                    VStack(spacing: 0) {
                        
                        HStack() {
                            Text("Цирк семьи пайло")
                                .foregroundStyle(Color.gray)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 40)
                                .padding(.bottom, 9)
                            
                            Spacer()
                            
                            Selector(mode: .readerControls) { i in
                                if i == 0 {
                                    settingsPresented.toggle()
                                } else {
                                    presented.toggle()
                                    settingsPresented = false
                                }
                            }
                            .padding([.trailing, .top], 15)
                        }
                    }
                    
                   
                    VStack {
                        Spacer()
                        Text("58 %")
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 20)
                    }
                    .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        SettingsView(presented: $settingsPresented)
                    }
                }
            }
        }
    }
    
    //MARK: - ContentUpdate

    
    private func contentUpdate(_ content: Book,
                               _ geometry: GeometryProxy,
                               _ uIFont: UIFont,
                               _ interval: CGFloat,
                               _ padding: CGFloat) {

        textLinesOfCurrentPage = []
        textLinesOfNextPage = []
        
        var tempBlock = firstBlockOfCurrentPage
        var tempWord = firstWordOfCurrentPage
        

        let maxWidht = geometry.size.width - padding * 2
        var maxHeight: CGFloat = geometry.size.height
        if geometry.size.height > geometry.size.width {
            maxHeight -= 100
        } else {
            maxHeight -= 110
        }
        var tempHeight: CGFloat = 0
        
        
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)

            if maxHeight < tempHeight + wordsLine.textHight + interval { break }
            tempHeight += wordsLine.textHight + interval
            
            textLinesOfCurrentPage.append(wordsLine)
            tempBlock = wordsLine.nextBlock
            tempWord = wordsLine.nextWord
            if wordsLine.isEndOfContent {return}
        }
        
        firstBlockOfNextPage = tempBlock
        firstWordOfNextPage = tempWord
        tempHeight = 0
    
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
            if maxHeight < tempHeight + wordsLine.textHight + interval { return }
            tempBlock = wordsLine.nextBlock
            tempWord = wordsLine.nextWord
            
            textLinesOfNextPage.append(wordsLine)
            tempHeight += wordsLine.textHight + interval
            if wordsLine.isEndOfContent {return}
        }
    }
}


#Preview {
    ReaderView(presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
