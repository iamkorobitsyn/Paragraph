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

struct Book: Identifiable {
    let id = UUID()
    let title: String?
    let author: String?
    let coverImage: String?
    let status: BookStatus
    let progress: Double
}
