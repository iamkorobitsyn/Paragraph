//
//  Models.swift
//  Paragraph
//
//  Created by Александр Коробицын on 13.03.2025.
//

import Foundation
import SwiftUI

enum BookStatus {
    case closed
    case open
    case completed
}

enum TextMode {
    case title
    case subTitle
    case paragraph
    case annotation
    case verse
    case caption
    case indent
}

struct Book: Identifiable {
    let id = UUID()
    let title: String?
    let author: String?
    let coverImage: String?
    let status: BookStatus
    let progress: Double
    let bookParts: [BookPart]
}

struct BookPart {
    let textBlocks: [TextBlock]
}

struct TextBlock {
    let text: [Word]
    let mode: TextMode
}

struct Word {
    let id: Int?
    let text: String
}

struct TextLinesPart {
    let text: [TextLine]
    let height: CGFloat
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




