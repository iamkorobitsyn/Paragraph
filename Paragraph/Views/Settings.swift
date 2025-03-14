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
    

    let corner = RectangleCornerRadii(topLeading: 20, bottomLeading: 0, bottomTrailing: 0, topTrailing: 20)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white).opacity(0.3)
                .clipShape(UnevenRoundedRectangle(cornerRadii: corner))
            
            List() {
                fontStyleCell()
                fontScaleCell()
                testSwitchCell()
                testCell()
            }
            .padding(.leading, 20)
            .listStyle(.plain)
            HStack {
                VStack {
                    Button(action: { presented.toggle() }) {
                        Image("closeWhite")
                    }
                    Spacer()
                }
                Spacer()
            }
           
        }
    }
}

#Preview {
    ZStack {
        Color(.gray).ignoresSafeArea()
        SettingsView(presented: .constant(true))
    }
   
}
