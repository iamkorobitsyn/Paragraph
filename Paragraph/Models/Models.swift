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
    case bookTitle
    case bookAuthor
    case chapterTitle
    case subTitle
    case paragraph
    case annotation
    case citation
    case list
    case verse
}

struct Book: Identifiable {
    let id = UUID()
    let title: String?
    let author: String?
    let coverImage: String?
    let status: BookStatus
    let progress: Double
    let textBlocks: [TextBlock]
}

struct TextBlock {
    let text: [Word]
    let mode: TextMode
}

struct Word {
    let id: Int
    let text: String
}

struct TextLine {
    
    init(_ text: [Word], _ mode: TextMode, _ textHight: CGFloat, _ isStartOfBlock: Bool, _ isEndOfBlock: Bool, _ isEndOfContent: Bool, _ nextBlock: Int, _ nextWord: Int) {
        self.text = text
        self.mode = mode
        self.textHight = textHight
        self.isStartOfBlock = isStartOfBlock
        self.isEndOfBlock = isEndOfBlock
        self.isEndOfContent = isEndOfContent
        self.nextBlock = nextBlock
        self.nextWord = nextWord
    }
    
    let text: [Word]
    let mode: TextMode
    let textHight: CGFloat
    let isStartOfBlock: Bool
    let isEndOfBlock: Bool
    let isEndOfContent: Bool
    let nextBlock: Int
    let nextWord: Int
}




