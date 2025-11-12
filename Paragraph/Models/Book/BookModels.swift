//
//  BookModels.swift
//  Paragraph
//
//  Created by iamkorobitsyn on 11.11.2025.
//

import Foundation


enum BookStatus {
    case closed
    case open
    case completed
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
