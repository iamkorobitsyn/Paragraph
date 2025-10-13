//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @State private var firstPartOfCurrentPage: Int = 1
    
    @State private var textLinesOfPreviousPage: TextLinesPart = TextLinesPart(scroll: false, textLines: [])
    @State private var textLinesOfCurrentPage: TextLinesPart = TextLinesPart(scroll: false, textLines: [])
    @State private var textLinesOfNextPage: TextLinesPart = TextLinesPart(scroll: false, textLines: [])
    
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
                             nextPage: textLinesOfNextPage)

                             .ignoresSafeArea()
                            
                    
                    VStack(spacing: 0) {
                        VStack {
                            Spacer()
                            Selector(mode: .readerControls) { i in
                                if i == 0 {
                                    settingsPresented.toggle()
                                } else {
                                    presented.toggle()
                                    settingsPresented = false
                                }
                            }
                        }
                            
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
        
        var tempLines: [TextLine] = []
        
        let tempPart = firstPartOfCurrentPage
        var tempBlock = 0
        var tempWord = 0
        var endContent: Bool = false
        var scrollFlag: Bool = false

        let maxWidht = geometry.size.width - (padding * 2)
        let spacerWidth = " ".widthOfString(usingFont: uIFont)
        
        //MARK: - previous content
        
        
        while !endContent {
            
            if tempPart == 0 {break}
            let wordsLine = textService.getLine(content: content,
                                                part: tempPart - 1, block: tempBlock, word: tempWord,
                                                maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
            
            tempBlock = wordsLine.endBlock
            tempWord = wordsLine.endWord
            
            tempLines.append(wordsLine)
            if wordsLine.endContent {endContent = true}
            
            if wordsLine.mode == .title {
                scrollFlag = false
            } else {
                scrollFlag = true
            }
        }
        
        textLinesOfPreviousPage = TextLinesPart(scroll: scrollFlag, textLines: tempLines)
        
        
        tempBlock = 0
        tempWord = 0
        tempLines = []
        endContent = false
        
        
        //MARK: - current content

        
        while !endContent {
            let wordsLine = textService.getLine(content: content,
                                                part: tempPart, block: tempBlock, word: tempWord,
                                                maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
            
            tempBlock = wordsLine.endBlock
            tempWord = wordsLine.endWord
            
            tempLines.append(wordsLine)
            if wordsLine.endContent {endContent = true}
            
            if wordsLine.mode == .title {
                scrollFlag = false
            } else {
                scrollFlag = true
            }
            
        }
        
        textLinesOfCurrentPage = TextLinesPart(scroll: scrollFlag, textLines: tempLines)
        
        tempLines = []
        endContent = false

        
        //MARK: = next content
        
        while !endContent {
            
            if tempPart == content.bookParts.count - 1 {break}

            let wordsLine = textService.getLine(content: content,
                                                part: tempPart + 1, block: tempBlock, word: tempWord,
                                                maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
            
            tempBlock = wordsLine.endBlock
            tempWord = wordsLine.endWord
            
            tempLines.append(wordsLine)
            if wordsLine.endContent {endContent = true}
            
            if wordsLine.mode == .title {
                scrollFlag = false
            } else {
                scrollFlag = true
            }
            
        }
        
        textLinesOfNextPage = TextLinesPart(scroll: scrollFlag, textLines: tempLines)
    }
}


#Preview {
    ReaderView(presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
