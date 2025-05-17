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
    
    @State private var endFlag: Bool = false
    
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
                    
                    //MARK: - PageView
                    
                    PageView(font: font,
                             interval: interval,
                             padding: padding,
                             backgroundColor: backgroundColor,
                             textColor: textColor,
                             previousPage: textLinesOfPreviousPage,
                             currentPage: textLinesOfCurrentPage,
                             nextPage: textLinesOfNextPage) { reverse in
                        if !reverse {
                            
                            let tempNextTextLines = textLinesOfNextPage
                            
                            if !tempNextTextLines.isEmpty {
                                firstBlockOfCurrentPage = firstBlockOfNextPage
                                firstWordOfCurrentPage = firstWordOfNextPage
                                textLinesOfCurrentPage = tempNextTextLines
                                contentUpdate(textService.content, geometry, uIFont, interval, padding)
                            }
//                            print("previous\(firstBlockOfPreviousPage)")
//                            print("previous\(firstWordOfPreviousPage)")
//                            
//                            print("current\(firstBlockOfCurrentPage)")
//                            print("current\(firstWordOfCurrentPage)")
//                            
//                            print("next\(firstBlockOfNextPage)")
//                            print("next\(firstWordOfNextPage)")
                        } else {
                            let tempPreviousTextLines = textLinesOfPreviousPage
                            firstBlockOfCurrentPage = firstBlockOfPreviousPage
                            firstWordOfCurrentPage = firstWordOfPreviousPage
                            textLinesOfCurrentPage = tempPreviousTextLines
                            contentUpdate(textService.content, geometry, uIFont, interval, padding)

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
        
        var tempBlock = 0
        var tempWord = 0
        
        let lineHeight = textService.heightOfString(font: uIFont) + interval
        var tempHeight: CGFloat = 0
        
        textService.tempHypernationWord = nil
        
        var maxHeight: CGFloat = geometry.size.height
        let maxWidht = geometry.size.width - (padding * 2)
        maxHeight -= geometry.size.height > geometry.size.width ? 100 : 110
        
        // PreviousPage
        
        if firstBlockOfCurrentPage != 0 || firstWordOfCurrentPage != 0 {

            let endWord = firstWordOfCurrentPage
            var focusBlock = firstBlockOfCurrentPage

            var endBlockFlag = false
            
            var tempTextLines: [TextLine] = []
            
            while tempWord < endWord {
                
                if maxHeight > tempHeight + lineHeight {
                    
                    let wordsLine = textService.getLine(content: content, block: focusBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)

                    tempWord = wordsLine.endWord
                    
                    tempTextLines.append(wordsLine)
                    tempHeight += lineHeight
                    endBlockFlag = wordsLine.isEndOfBlock
                    
                } else {
                    
                    let wordsLine = textService.getLine(content: content, block: focusBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                    
                    tempWord = wordsLine.endWord
                    
                    tempTextLines.removeFirst()
                    tempTextLines.append(wordsLine)
                }
            }
            
            print(tempTextLines)
            
            textLinesOfPreviousPage.append(contentsOf: tempTextLines)
            tempTextLines = []
            
            while maxHeight > tempHeight + lineHeight {
                if focusBlock == 0 {
                    tempBlock = 0
                    tempWord = 0
                    tempHeight = 0
                    textLinesOfPreviousPage = []
                    
                    while maxHeight > tempHeight + lineHeight {
                        
                        let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                        tempHeight += lineHeight
                        
                        textLinesOfPreviousPage.append(wordsLine)
                        tempBlock = wordsLine.endBlock
                        tempWord = wordsLine.endWord
                    }
                    break
                } else {
                    tempWord = 0
                    focusBlock -= 1
                }
                
                
                while !endBlockFlag {
                    if maxHeight < tempHeight + lineHeight { tempTextLines.removeFirst() }
                    
                    let wordsLine = textService.getLine(content: content, block: tempBlock, word: tempWord, maxWidth: maxWidht, uIFont: uIFont)
                    tempHeight += lineHeight
                    
                    tempTextLines.append(wordsLine)
                    tempBlock = wordsLine.endBlock
                    tempWord = wordsLine.endWord
                    endBlockFlag = wordsLine.isEndOfBlock
                }

                textLinesOfPreviousPage.insert(contentsOf: tempTextLines, at: 0)
                tempTextLines = []
                tempBlock = 0
                tempWord = 0
                endBlockFlag.toggle()
            }
        }
        
        if !textLinesOfPreviousPage.isEmpty {
            firstBlockOfPreviousPage = textLinesOfPreviousPage[0].startBlock
            firstWordOfPreviousPage = textLinesOfPreviousPage[0].startWord
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
