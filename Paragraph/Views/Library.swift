//
//  LibraryListView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct LibraryView: View {
    
    @Binding var readerPresented: Bool
    let books: [Book]

    var body: some View {
        if !readerPresented {
            List(books, id: \.id) { book in
                BookCell(book: book)
                    .listRowInsets(.none) // Убираем отступы у ячейки
                    .listRowSeparator(.hidden) // Скрываем разделитель
                    .listRowBackground(Color.clear) // Прозрачный фон ячейки
            }
            .listStyle(.plain) // Убираем стиль списка по умолчанию
                    .padding(.horizontal, 0) // Убираем горизонтальные отступы у списка
        }
    }
}

#Preview {
    ZStack {
        Color(.gray)
        LibraryView(readerPresented: .constant(false),
                    books: [
            Book(title: "Beartown",
                 author: "Fredrik Backman",
                 coverImage: "Beartown Fredrik Backman",
                 status: .closed,
                 progress: 0.33,
                 text: [],
                 progressBlock: 2,
                 progressWord: 10),
            
            Book(title: "My grandmother asked me to tell you shes sorry",
                 author: "Fredrik Backman",
                 coverImage: "My grandmother asked me to tell you shes sorry   Fredrik Backman",
                 status: .open,
                 progress: 0.95,
                 text: [],
                 progressBlock: 2,
                 progressWord: 10),
            
            Book(title: "Things my son needs to know about the world",
                 author: "Fredrik Backman",
                 coverImage: "Things my son needs to know about the world  Fredrik Backman",
                 status: .completed,
                 progress: 0.0,
                 text: [],
                 progressBlock: 2,
                 progressWord: 10)
        ])
    }
}
