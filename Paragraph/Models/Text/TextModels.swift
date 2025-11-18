//
//  TextModels.swift
//  Paragraph
//
//  Created by iamkorobitsyn on 11.11.2025.
//

import Foundation

enum TextMode {
    case title
    case subTitle
    case paragraph
    case annotation
    case verse
    case caption
    case indent
}

struct TextLine {
    
    init(text: [Word], mode: TextMode, endPart: Int, endBlock: Int, endWord: Int,
         startFlag: Bool, endFlag: Bool, endContent: Bool, height: CGFloat) {
        self.text = text
        self.mode = mode
        self.endPart = endPart
        self.endBlock = endBlock
        self.endWord = endWord
        self.startFlag = startFlag
        self.endFlag = endFlag
        self.endContent = endContent
        self.height = height
    }
    
    let text: [Word]
    let mode: TextMode
    let endPart: Int
    let endBlock: Int
    let endWord: Int
    let startFlag: Bool
    let endFlag: Bool
    let endContent: Bool
    let height: CGFloat
}

struct TextPart {
    let text: [TextLine]
    let height: CGFloat
}

struct TextLoadingContent {
    let previousPart: TextPart
    let currentPart: TextPart
    let nextPart: TextPart
}


