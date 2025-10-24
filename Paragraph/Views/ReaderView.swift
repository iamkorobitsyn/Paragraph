//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @Binding var selfPresented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @AppStorage("progressPart") private var progressPart = 0
    @AppStorage("progressLine") private var progressLine = 0
    
    @State private var previousPage = TextLinesPart(text: [], height: 0)
    @State private var currentPage = TextLinesPart(text: [], height: 0)
    @State private var nextPage = TextLinesPart(text: [], height: 0)
    @State private var isContentReady = false
    
    var body: some View {
        
        let font = textService.getFont()
        let uIFont = textService.getUIFont()
        
        let interval = textService.getInterval()
        let padding = textService.getPadding()
        
        let backgroundColor = colorService.theme().background
        let textColor = colorService.theme().text
  
        if selfPresented {
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
                    .onChange(of: progressPart) {
                        contentUpdate(textService.content, geometry, uIFont, interval, padding)
                    }
                
                
                ZStack(alignment: .top) {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    
                    //MARK: - PageView
                    
                            if isContentReady {
                                VStack(spacing: 0) {
                                    TopMarginLine(width: geometry.size.width - padding * 2)
                                    TextView(backColor: backgroundColor,
                                             textColor: textColor,
                                             font: font,
                                             interval: interval,
                                             padding: padding,
                                             prevPage: $previousPage,
                                             currentPage: $currentPage,
                                             nextPage: $nextPage,
                                             updateContent: { swipeState in
                                        switch swipeState {
                                            
                                        case .previous: progressPart -= 1
                                        case .next: progressPart += 1
                                        }
                                    })
                                    .ignoresSafeArea()
                                }
                                                                

  
                                VStack(spacing: 0) {
                                    VStack {
                                        Spacer()
                                        Selector(mode: .readerControls) { i in
                                            if i == 0 {
                                                settingsPresented.toggle()
                                            } else {
                                                selfPresented.toggle()
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
    }
    
    //MARK: - ContentUpdate

    
    private func contentUpdate(_ content: Book,
                               _ geometry: GeometryProxy,
                               _ uIFont: UIFont,
                               _ interval: CGFloat,
                               _ padding: CGFloat) {
        
            var tempLines: [TextLine] = []
            
            var tempBlock = 0
            var tempWord = 0
            var tempHeight: CGFloat = 0
            var endContent: Bool = false
            
            let maxWidht = geometry.size.width - (padding * 2)
            let spacerWidth = " ".widthOfString(usingFont: uIFont)
            
            //MARK: - previous content
            
            
            while !endContent {
                
                if progressPart == 0 {break}
                let wordsLine = textService.getLine(content: content,
                                                    part: progressPart - 1, block: tempBlock, word: tempWord,
                                                    maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
                
                tempBlock = wordsLine.endBlock
                tempWord = wordsLine.endWord
                tempHeight += textService.heightOfString(font: uIFont)
                
                tempLines.append(wordsLine)
                if wordsLine.endContent {endContent = true}
                
            }
            
            previousPage = TextLinesPart(text: tempLines, height: tempHeight)
            
            
            
            tempBlock = 0
            tempWord = 0
            tempHeight = 0
            tempLines = []
            endContent = false
            
            
            //MARK: - current content
            
            while !endContent {
                let wordsLine = textService.getLine(content: content,
                                                    part: progressPart, block: tempBlock, word: tempWord,
                                                    maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
                
                tempBlock = wordsLine.endBlock
                tempWord = wordsLine.endWord
                tempHeight += textService.heightOfString(font: uIFont)
                tempLines.append(wordsLine)
                if wordsLine.endContent {endContent = true}
                
            }
            currentPage = TextLinesPart(text: tempLines, height: tempHeight)
            tempHeight = 0
            tempLines = []
            endContent = false
            
            
            //MARK: = next content
            
            while !endContent {
                
                if progressPart == content.bookParts.count - 1 {break}
                
                let wordsLine = textService.getLine(content: content,
                                                    part: progressPart + 1, block: tempBlock, word: tempWord,
                                                    maxWidth: maxWidht, spacerWidth: spacerWidth, uIFont: uIFont)
                
                tempBlock = wordsLine.endBlock
                tempWord = wordsLine.endWord
                tempHeight += textService.heightOfString(font: uIFont)
                tempLines.append(wordsLine)
                if wordsLine.endContent {endContent = true}
                
                
            }
            nextPage = TextLinesPart(text: tempLines, height: tempHeight)
        
        isContentReady = true
        }
    
}


#Preview {
    ReaderView(selfPresented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
