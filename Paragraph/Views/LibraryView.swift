//
//  LibraryListView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct LibraryView: View {
    
    let books: [Book]
    let cellWidth: CGFloat
    
    var body: some View {
        List(books, id: \.id) { book in
            BookCell(book: book, cellWidth: cellWidth)
                .frame(maxWidth: .infinity, alignment: .center) // Выравнивание по центру
                .listRowSeparator(.hidden) // Скрываем разделители
                .listRowBackground(Color.clear) // Прозрачный фон
        }
        .listStyle(PlainListStyle()) // Убираем стиль списка по умолчанию
        .background(Color.clear) // Фон для всей таблицы
    }     
}

#Preview {
    ZStack {
        Color(.gray)
        LibraryView(books: [
            Book(title: "Beartown",
                 author: "Fredrik Backman",
                 coverImage: "Beartown Fredrik Backman",
                 status: .closed,
                 progress: 0.33),
            Book(title: "My grandmother asked me to tell you shes sorry",
                 author: "Fredrik Backman",
                 coverImage: "My grandmother asked me to tell you shes sorry   Fredrik Backman",
                 status: .open,
                 progress: 0.95),
            Book(title: "Things my son needs to know about the world",
                 author: "Fredrik Backman",
                 coverImage: "Things my son needs to know about the world  Fredrik Backman",
                 status: .completed,
                 progress: 0.0)
        ], cellWidth: 320)
    }
}
