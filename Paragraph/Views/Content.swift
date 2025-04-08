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
             progress: 0.33,
             text: []),
        Book(title: "My grandmother asked me to tell you shes sorry",
             author: "Fredrik Backman",
             coverImage: "My grandmother asked me to tell you shes sorry   Fredrik Backman",
             status: .open,
             progress: 0.95,
             text: []),
        Book(title: "Things my son needs to know about the world",
             author: "Fredrik Backman",
             coverImage: "Things my son needs to know about the world  Fredrik Backman",
             status: .completed,
             progress: 0.0,
             text: [])
    ]
    
    @State private var device = UIDevice.current.userInterfaceIdiom
    @State private var readerPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            Color(.clear)
                .onAppear()
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                        .ignoresSafeArea()
                    
                    ReaderView(device: device, presented: $readerPresented)
                    
                    HStack(spacing: 0) {
                        
                        ToolBarView(readerPresented: $readerPresented, device: device)
                            .frame(width: device == .pad ? 560 : 360,
                                   height: device == .pad ? 250 : 200)
                            .padding(.leading, 20)
                        
                        LibraryView(readerPresented: $readerPresented, books: books)
                    }
                }
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                        .ignoresSafeArea()
                    
                    ReaderView(device: device, presented: $readerPresented)
                    
                    VStack(spacing: 0) {
                        ToolBarView(readerPresented: $readerPresented, device: device)
                        .frame(width: device == .pad ? 560 : 360,
                               height: device == .pad ? 250 : 200)
                        .padding(.top, 100)
                        
                        LibraryView(readerPresented: $readerPresented, books: books)
                            .frame(width: device == .pad ? 560 : 360)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
