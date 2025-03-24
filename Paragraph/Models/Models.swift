//
//  Models.swift
//  Paragraph
//
//  Created by Александр Коробицын on 13.03.2025.
//

import Foundation

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
    let text: [TextBlock]
    let progressBlock: Int
    let progressWord: Int
}

struct TextBlock {
    let words: [String]
    let mode: TextMode
}




