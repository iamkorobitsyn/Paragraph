//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
//

import SwiftUI

struct PageView<Content: View>: View {
    let pages: [Content]
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<pages.count, id: \.self) { index in
                    pages[index]
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .offset(x: -CGFloat(currentIndex) * geometry.size.width)
            .animation(.easeInOut, value: currentIndex)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 && currentIndex < pages.count - 1 {
                            currentIndex += 1
                        } else if value.translation.width > 50 && currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
            )
        }
        .ignoresSafeArea()
    }
}
