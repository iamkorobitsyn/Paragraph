//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @State private var textLinesOfPreviousPage: [TextLine] = []
    @State private var textLinesOfCurrentPage: [TextLine] = []
    @State private var textLinesOfNextPage: [TextLine] = []
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var firstBlockOfPreviousPage: Int = 0
    @State private var firstWordOfPreviousPage: Int = 0
    
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
                             previousPage: textLinesOfPreviousPage,
                             currentPage: textLinesOfCurrentPage,
                             nextPage: textLinesOfNextPage) { withReverse in
                        if !withReverse {
                            firstBlockOfCurrentPage = firstBlockOfNextPage
                            firstWordOfCurrentPage = firstWordOfNextPage
                            if !textLinesOfNextPage.isEmpty {
                                let next = textLinesOfNextPage
                                contentUpdate(textService.content, geometry, uIFont, interval, padding)
                                textLinesOfCurrentPage = next
                            } else if !textLinesOfPreviousPage.isEmpty {
                                let previous = textLinesOfPreviousPage
                                contentUpdate(textService.content, geometry, uIFont, interval, padding)
                                textLinesOfCurrentPage = previous
                            }
                            
                        } else {
                            firstBlockOfCurrentPage = firstBlockOfPreviousPage
                            firstWordOfCurrentPage = firstWordOfPreviousPage
                            let prev = textLinesOfPreviousPage
                            contentUpdate(textService.content, geometry, uIFont, interval, padding)
                            textLinesOfCurrentPage = prev
                        }
                        
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

        textLinesOfPreviousPage = []
        textLinesOfCurrentPage = []
        textLinesOfNextPage = []
        
        var tempBlock = firstBlockOfCurrentPage
        var tempWord = 0
        
        let lineHeght = textService.heightOfString(font: uIFont) + interval
        
        textService.tempHypernationWord = nil
        

        let maxWidht = geometry.size.width - padding * 2
        var maxHeight: CGFloat = geometry.size.height
        if geometry.size.height > geometry.size.width {
            maxHeight -= 100
        } else {
            maxHeight -= 110
        }
        
        // PreviousPage
        
        var tempHeight: CGFloat = 0
        
        if firstBlockOfCurrentPage != 0 || firstWordOfCurrentPage != 0 {
            
            var tempTextLines: [TextLine] = []
            
            while tempHeight < maxHeight + lineHeght {
                if tempWord < content.textBlocks[tempBlock].text.count {
                    
                    let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                    
                    tempBlock = wordsLine.endBlock
                    tempWord = wordsLine.endWord
                    
                    tempTextLines.append(wordsLine)
                    tempHeight += textService.heightOfString(font: uIFont) + interval
                } else {
                    textLinesOfPreviousPage.append(contentsOf: tempTextLines)
                    tempWord = 0
                    if tempBlock != 0 {
                        tempBlock -= 1
                    }
                }
            }
            
            while tempWord < content.textBlocks[tempBlock].text.count {
                let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                
                tempBlock = wordsLine.endBlock
                tempWord = wordsLine.endWord
                tempTextLines.removeFirst()
                tempTextLines.append(wordsLine)
                tempHeight += textService.heightOfString(font: uIFont) + interval
            }
            
            textLinesOfPreviousPage.insert(contentsOf: tempTextLines, at: 0)
            
            firstBlockOfPreviousPage = textLinesOfPreviousPage.first!.startBlock
            firstWordOfPreviousPage = textLinesOfPreviousPage.first!.startWord
            
        }
        
        //MARK: - CurrentPage
        
        tempBlock = firstBlockOfCurrentPage
        tempWord = firstWordOfCurrentPage
        tempHeight = 0
        
        while tempHeight < maxHeight {
            
            if maxHeight < tempHeight + textService.heightOfString(font: uIFont) + interval {
                break
            } else {
                let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                tempHeight += textService.heightOfString(font: uIFont) + interval
                
                textLinesOfCurrentPage.append(wordsLine)
                tempBlock = wordsLine.endBlock
                tempWord = wordsLine.endWord
                if wordsLine.isEndOfContent {return}
            }
            
        }
        
        firstBlockOfNextPage = tempBlock
        firstWordOfNextPage = tempWord
        
        //MARK: - NextPage

        tempHeight = 0
    
        while tempHeight < maxHeight {
            
            let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
            
            if maxHeight < tempHeight + textService.heightOfString(font: uIFont) + interval { break }
            tempBlock = wordsLine.endBlock
            tempWord = wordsLine.endWord
            
            textLinesOfNextPage.append(wordsLine)
            tempHeight += textService.heightOfString(font: uIFont) + interval
            
            if wordsLine.isEndOfContent {break}
        }
        
        tempBlock = firstBlockOfCurrentPage
        tempWord = firstWordOfCurrentPage
        
        tempHeight = 0
        
        
    }
}


#Preview {
    ReaderView(presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
