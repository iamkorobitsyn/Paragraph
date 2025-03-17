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

    @State private var toolbarPresented: Bool = true
    @State private var settingsPresented: Bool = false
    @State private var readerPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    ReaderView(readerPresented: $readerPresented)
                        .opacity(readerPresented ? 1 : 0)
                    HStack(spacing: 0) {

                            ZStack {
                                VStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width: device == .pad ? 560 : 360,
                                               height: geometry.size.height / 6)
                                    SettingsView(presented: $settingsPresented)
                                        .frame(width: device == .pad ? 560 : 360)
                                        .padding(.leading, device == .pad ? 20 : 70)
                                }
                                
                                ToolBarView(settingsPresented: $settingsPresented,
                                            readerPresented: $readerPresented,
                                            paddingSelector: device == .pad ? 60 : 40)
                                .frame(width: device == .pad ? 560 : 360,
                                       height: device == .pad ? 250 : 200)
                                .padding(.leading, device == .pad ? 20 : 70)
                                .opacity(settingsPresented || readerPresented ? 0 : 1)
                            }
                            LibraryView(books: books)
                            .opacity(readerPresented ? 0 : 1)
                    }
                }.ignoresSafeArea()
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    ReaderView(readerPresented: $readerPresented)
                        .opacity(readerPresented ? 1 : 0)
                    VStack(spacing: 0) {
                        ToolBarView(settingsPresented: $settingsPresented,
                                    readerPresented: $readerPresented,
                                    paddingSelector: device == .pad ? 60 : 40)
                        .frame(width: device == .pad ? 560 : 360,
                               height: device == .pad ? 250 : 200)
                        .padding(.top, 150)
                        .opacity(settingsPresented || readerPresented ? 0 : 1)
                        LibraryView(books: books)
                            .frame(width: device == .pad ? 560 : 360)
                            .opacity(readerPresented || settingsPresented ? 0 : 1)
                    }
                    SettingsView(presented: $settingsPresented)
                        .frame(width: device == .pad ? 560 : 360)
                        .padding(.top, 150)
                }.ignoresSafeArea()
            }
        }
    }
}



#Preview {
    return ContentView()
}
