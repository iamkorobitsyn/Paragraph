//
//  SettingsView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    let sizeWidth: CGFloat
    let paddingEdge: Edge.Set
    let paddingPoint: CGFloat
    
    @Binding var toolBarIsPresented: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white).opacity(0.3)
                .frame(width: sizeWidth)
                .cornerRadius(20)
            Button(action: { toolBarIsPresented.toggle() }) {
                Image("settingsClose")
            }
                
        }
        .padding(paddingEdge, paddingPoint)
    }
        
}

#Preview {
    ZStack {
        Color(.gray).ignoresSafeArea()
        SettingsView(sizeWidth: 360, paddingEdge: .top, paddingPoint: 150, toolBarIsPresented: .constant(true))
    }
   
}
