//
//  ContentView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

struct MainView: View {
    
    let books: [Book] = [
        Book(title: "Beartown",
             author: "Fredrik Backman",
             coverImage: "Beartown Fredrik Backman",
             status: .closed,
             progress: 0.33,
             bookParts: []),
        Book(title: "My grandmother asked me to tell you shes sorry",
             author: "Fredrik Backman",
             coverImage: "My grandmother asked me to tell you shes sorry   Fredrik Backman",
             status: .open,
             progress: 0.95,
             bookParts: []),
        Book(title: "Things my son needs to know about the world",
             author: "Fredrik Backman",
             coverImage: "Things my son needs to know about the world  Fredrik Backman",
             status: .completed,
             progress: 0.0,
             bookParts: [])
    ]
    
    
    
    @State private var device = UIDevice.current.userInterfaceIdiom
    @State private var readerPresented: Bool = false
    @EnvironmentObject private var textService: TextService
    
    var body: some View {

            
            ZStack {
                Image("mainTexture")
                    .resizable()
                    .ignoresSafeArea()
                
                ReaderView(selfPresented: $readerPresented)
                    .onAppear() {
                        textService.setPaddingList(landscape: false)
                    }
                VStack(spacing: 0) {
                    HeaderView(readerPresented: $readerPresented)
                    .frame(width: device == .pad ? 560 : 360,
                           height: device == .pad ? 250 : 200)
                    .padding(.top, 100)
                    
                    LibraryView(readerPresented: $readerPresented, books: books)
                        .frame(width: device == .pad ? 560 : 360)
                }
            }
    }
}


#Preview {
    MainView()
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
