//
//  PageView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 01.04.2025.
import SwiftUI

struct BookReader: View {
    @State private var selectedPage = 1
    @State private var pageOffset: CGFloat = 0
    let pages = [Color.green, Color.blue, .clear]
    
    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(pages.indices, id: \.self) { index in
                GeometryReader { geometry in
                    pages[index]
                        .overlay(
                            VStack {
                                Text("Страница \(index + 1)")
                                Text("Смещение: \(Int(geometry.frame(in: .global).minX))")
                            }
                        )
                        .onChange(of: geometry.frame(in: .global).minX) { oldValue, newValue in
                            pageOffset = newValue
                            print("Страница \(index): смещение \(newValue)")
                        }
                }
                .onAppear { print("Страница \(index) стала видимой") }
                .onDisappear {
                    print("Страница \(index) скрылась")
                    selectedPage = 1
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            Text("Текущее смещение: \(Int(pageOffset))")
                .padding()
                .background(.white)
                .padding(.top, 50)
        )
    }
}

#Preview {
    BookReader()
}
