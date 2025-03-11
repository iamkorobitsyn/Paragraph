//
//  ContentView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentIndex = 1
    
    var body: some View {
        
        ZStack {
            Selector(mode: .settingsLeafing(currentIndex)) { i in
                test(index: i)
            }
        }
    }
    
    private func test(index: Int) {
        currentIndex = index
        print(index)
    }
}



#Preview {
    return ContentView()
}
