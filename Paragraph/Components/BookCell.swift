//
//  BookCell.swift
//  Paragraph
//
//  Created by Александр Коробицын on 13.03.2025.
//

import Foundation
import SwiftUI

struct BookCell: View {
    
    let book: Book
    
    var body: some View {
        VStack(spacing: 5) {
            Rectangle()
                .frame(height: 4)
                .foregroundStyle(.white).opacity(0.3)
                .cornerRadius(2)
            
            HStack(alignment: .top, spacing: 20) {
                
                VStack(spacing: 0) {
                    Image(book.coverImage ?? "")
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 100, height: 150)
                    Image("detailsWhiteIcon")
                }
                
                ZStack() {
                    Rectangle().fill(.clear)
                    VStack(spacing: 10) {
                        Text(book.title ?? "")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .medium))
                            .frame(height: 70, alignment: .bottom)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundStyle(Color.customGrayDeep)
                                .frame(width: 100, height: 1)
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(width: book.progress * 100, height: 6)
                                .cornerRadius(3)
                        }
                        
                        Text(book.author ?? "")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .light))
                            .frame(height: 70, alignment: .top)
                    }
                }.frame(height: 150)
                
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        BookCell(book: Book(title: "Beartown",
                            author: "Fredrik Backman",
                            coverImage: "Beartown Fredrik Backman",
                            status: .closed,
                            progress: 0.78,
                            bookParts: []))
    }
    
}
