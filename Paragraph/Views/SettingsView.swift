//
//  SettingsView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @Binding var presented: Bool
    
    var body: some View {
        if presented {
            VStack {
//                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 2) {
                        HStack {
                            ColorThemeCell()
                            Spacer()
                        }
                        fontStyleCell()
                        FontSizeCell()
                        LineIntervalCell()
                        PaddingSizeCell()
                        HStack {
                            Spacer()
                            TransferOfWordsCell()
                        }
                    }
                    .frame(width: 300, height: 350)
                    .padding(.trailing, 10)
//                    .padding(.bottom, 50)
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
}

#Preview {
    ZStack() {
        Color(.gray).ignoresSafeArea()
        SettingsView(presented: .constant(true))
            .environmentObject(TextTypographyHelper())
    }
    
}
