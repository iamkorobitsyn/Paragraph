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

    @State private var toolBarIsPresented: Bool = true
    @State private var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    HStack(spacing: 0) {
                        if toolBarIsPresented {
                            ToolBarView(presented: $toolBarIsPresented,
                                        paddingSelector: device == .pad ? 60 : 40)
                            .frame(width: device == .pad ? 560 : 360,
                                   height: device == .pad ? 250 : 200)
                            .padding(.leading, device == .pad ? 20 : 70)
                            LibraryView(books: books)
                        } else {
                            VStack() {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: device == .pad ? 560 : 360,
                                           height: geometry.size.height / 6)
                                SettingsView(presented: $toolBarIsPresented)
                                    .frame(width: device == .pad ? 560 : 360)
                                    .padding(.leading, device == .pad ? 20 : 70)
                            }
                            LibraryView(books: books)
                        }
                    }
                }.ignoresSafeArea()
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    if toolBarIsPresented {
                        VStack(spacing: 0) {
                            ToolBarView(presented: $toolBarIsPresented,
                                        paddingSelector: device == .pad ? 60 : 40)
                                .frame(width: device == .pad ? 560 : 360,
                                       height: device == .pad ? 250 : 200)
                            .padding(.top, 150)
                            LibraryView(books: books)
                                .frame(width: device == .pad ? 560 : 360)
                        }
                    } else {
                        VStack(spacing: 0) {
                            SettingsView(presented: $toolBarIsPresented)
                                .frame(width: device == .pad ? 560 : 360)
                                .padding(.top, 150)
                        }
                    }
                }.ignoresSafeArea()
            }
        }
    }
}



#Preview {
    return ContentView()
}
