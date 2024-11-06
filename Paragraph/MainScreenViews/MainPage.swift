//
//  PortraitStackView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 16.05.2024.
//

import SwiftUI

struct MainPage: View {


    let gradientColors: [Color]
    
    let languages = ["minus", "plus"]
    
    @State private var selectedLanguage = 0
    
    var body: some View {
        
        
        ZStack {
            LinearGradient(colors: gradientColors,
                           startPoint: .top,
                           endPoint: .bottom)
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.white).opacity(0.4)
                        .blur(radius: 0.5)
                        .frame(width: 350, height: 100)
                        .clipShape(.rect(cornerRadius: 40))
                    Picker("Select language", selection: $selectedLanguage) {
                        ForEach(0..<languages.count) { index in
                            Image(systemName: languages[index])
                        }
                    }
                    
                    .pickerStyle(.palette)
                    .frame(width: 200, height: 100)
                    
                        
                }.padding(.top, 120)
                    
                
                Spacer()
            }
        }.ignoresSafeArea()
    }
}
