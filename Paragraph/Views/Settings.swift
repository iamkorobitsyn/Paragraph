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
            
            List {
                fontStyleCell()
                    .listRowBackground(Color.clear)
                fontScaleCell()
                    .listRowBackground(Color.clear)
                testSwitchCell()
                    .listRowBackground(Color.clear)
                fontScaleCell()
                    .listRowBackground(Color.clear)
                testCell()
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            HStack {
                VStack {
                    Button(action: { presented.toggle() }) {
                        Image("close")
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


//
//            VStack {
//                Toggle("Aa -", isOn: $isOn)
//                    .toggleStyle(SwitchToggleStyle(tint: .customGold))
//                    .font(.system(size: 20, weight: .light))
//                    .padding(100)
//                Toggle("|Aa   Aa|", isOn: $isOn)
//                    .toggleStyle(SwitchToggleStyle(tint: .customGold))
//                    .font(.system(size: 20, weight: .light))
//                    .padding(100)
//                Selector(mode: .settingsLessAndMore, action: {i in })
//                Selector(mode: .settingsBackAndForward, action: {i in })
//            }
