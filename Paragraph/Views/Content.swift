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
    
    @State private var toolbarPresented: Bool = true
    @State private var settingsPresented: Bool = false
    @State private var readerPresented: Bool = false
    
    
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                        .ignoresSafeArea()
                    ReaderView(readerPresented: $readerPresented,
                               settingsPresented: $settingsPresented)
                        .opacity(readerPresented ? 1 : 0)
                    SettingsView(presented: $settingsPresented)
                        .ignoresSafeArea()
                        .padding(.top, geometry.size.height / 2.5)
                    HStack(spacing: 0) {
                        
                        ZStack {
                            VStack {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: device == .pad ? 560 : 360,
                                           height: geometry.size.height / 6)
                                
//                                    .frame(width: device == .pad ? 560 : 360)
//                                    .padding(.leading, device == .pad ? 20 : 70)
                            }
                            
                            ToolBarView(settingsPresented: $settingsPresented,
                                        readerPresented: $readerPresented,
                                        paddingSelector: device == .pad ? 60 : 40)
                            .frame(width: device == .pad ? 560 : 360,
                                   height: device == .pad ? 250 : 200)
                            .padding(.leading, 20)
                            .opacity(settingsPresented || readerPresented ? 0 : 1)
                        }
                        LibraryView(books: books)
                            .opacity(readerPresented || settingsPresented ? 0 : 1)
                    }
                }
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                        .ignoresSafeArea()
                    ReaderView(readerPresented: $readerPresented,
                               settingsPresented: $settingsPresented)
                        .opacity(readerPresented ? 1 : 0)
                    VStack(spacing: 0) {
                        ToolBarView(settingsPresented: $settingsPresented,
                                    readerPresented: $readerPresented,
                                    paddingSelector: device == .pad ? 60 : 40)
                        .frame(width: device == .pad ? 560 : 360,
                               height: device == .pad ? 250 : 200)
                        .padding(.top, 120)
                        .opacity(settingsPresented || readerPresented ? 0 : 1)
                        LibraryView(books: books)
                            .frame(width: device == .pad ? 560 : 360)
                            .opacity(readerPresented || settingsPresented ? 0 : 1)
                    }
                    SettingsView(presented: $settingsPresented)
                        .padding(.top, geometry.size.height / 2)
                        .ignoresSafeArea()
                }
            }
        }
    }
}


#Preview {
    return ContentView()
        .environmentObject(TextService())
}
