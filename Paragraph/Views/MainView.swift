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
             progressPart: 0,
             bookParts: []),
        Book(title: "My grandmother asked me to tell you shes sorry",
             author: "Fredrik Backman",
             coverImage: "My grandmother asked me to tell you shes sorry   Fredrik Backman",
             status: .open,
             progressPart: 0,
             bookParts: []),
        Book(title: "Things my son needs to know about the world",
             author: "Fredrik Backman",
             coverImage: "Things my son needs to know about the world  Fredrik Backman",
             status: .completed,
             progressPart: 0,
             bookParts: [])
    ]
    
    @EnvironmentObject private var contentTestingHelper: ContentTestingHelper
    @State private var readerPresented: Bool = false
    
    var body: some View {

            
            ZStack {
                Image("mainTexture")
                    .resizable()
                    .ignoresSafeArea()
                
                ReaderView(selfPresented: $readerPresented)
                    

                VStack(spacing: 0) {
                    HeaderView(readerPresented: $readerPresented)
                    .frame(width: 360, height: 200)
                    .padding(.top, 100)
                    
                    LibraryView(readerPresented: $readerPresented, books: books)
                        .frame(width: 360)
                        .onAppear() {
                            contentTestingHelper.progressPart = 0
                            print(contentTestingHelper.progressPart)
                        }
                }
            }
    }
}


#Preview {
    MainView()
        .environmentObject(TextTypographyHelper())
        .environmentObject(ColorThemeHelper())
        .environmentObject(TextConstructHelper())
        .environmentObject(ContentTestingHelper())
}
