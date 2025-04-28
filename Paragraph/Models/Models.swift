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
    let id: Int?
    let text: String
}

struct TextLine {
    
    init(text: [Word], mode: TextMode,
         isStartOfBlock: Bool, isEndOfBlock: Bool, isEndOfContent: Bool,
         startBlock: Int, startWord: Int,
         endBlock: Int, endWord: Int) {
        self.text = text
        self.mode = mode
        self.isStartOfBlock = isStartOfBlock
        self.isEndOfBlock = isEndOfBlock
        self.isEndOfContent = isEndOfContent
        self.startBlock = startBlock
        self.startWord = startWord
        self.endBlock = endBlock
        self.endWord = endWord
    }
    
    let text: [Word]
    let mode: TextMode
    let isStartOfBlock: Bool
    let isEndOfBlock: Bool
    let isEndOfContent: Bool
    let startBlock: Int
    let startWord: Int
    let endBlock: Int
    let endWord: Int
}




