//
//  ContentView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    let books: [Book] = [
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
    ]

    @State private var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    
                    Color(.orange).opacity(0.1)
                    HStack(spacing: 0) {
                        ToolBar(sizeWidth: device == .pad ? 560 : 360,
                                sizeHeight: device == .pad ? 250 : 200,
                                paddingEdge: .leading,
                                paddingPoint: device == .pad ? 40 : 70)
                        LibraryView(books: books, cellWidth: device == .pad ? 520 : 320)
                    }
                    
                }.ignoresSafeArea()
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    Color(.orange).opacity(0.1)
                    VStack(spacing: 0) {
                        ToolBar(sizeWidth: device == .pad ? 560 : 360,
                                sizeHeight: device == .pad ? 250 : 200,
                                paddingEdge: .top, paddingPoint: 150)
                        LibraryView(books: books, cellWidth: device == .pad ? 520 : 320)
                    }
                }.ignoresSafeArea()
            }
        }
    }
}



#Preview {
    return ContentView()
}
