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
    
    let textLines: [TextLine]
    
    var body: some View {
        ZStack {
            Text("Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test")
                .opacity(calculateOpacity()) // opacity растёт при прокрутке
            
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
    
    private func calculateOpacity() -> Double {
        let screenWidth = UIScreen.main.bounds.width
        let normalizedOffset = abs(pageOffset / screenWidth)
        
        // opacity увеличивается от 0 до 1 при прокрутке
        return min(1, normalizedOffset)
    }
}

#Preview {
    BookReader(textLines: [TextLine([Word(id: 0, text: "kjfh")], .annotation, 34, false, false)])
}
