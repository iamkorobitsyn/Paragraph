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
    let cellWidth: CGFloat
    
    var body: some View {
        VStack() {
            Rectangle()
                .frame(width: cellWidth, height: 4)
                .foregroundStyle(.white).opacity(0.3)
                .cornerRadius(2)
            
            HStack(alignment: .top, spacing: 0) {
                
                VStack(spacing: 0) {
                    Image(book.coverImage ?? "")
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 100, height: 150)
                    Image("libraryDetails")
                }
                
                ZStack() {
                    VStack(spacing: 10) {
                        Text(book.title ?? "")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: cellWidth - 120, height: 70, alignment: .bottom)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundStyle(Color.customGray)
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
                            .frame(width: cellWidth - 120, height: 70, alignment: .top)
                    }
                    

                }.frame(width: cellWidth - 100, height: 150)
            }.frame(width: cellWidth)
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
                            progress: 0.78),
                 cellWidth: 300)
    }
    
}
