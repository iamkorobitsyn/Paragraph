//
//  Main.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct ToolBar: View {
    
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    let paddingEdge: Edge.Set
    let paddingPoint: CGFloat
    
    var body: some View {
        ZStack() {
            
            Rectangle()
                .fill(Color.white).opacity(0.3)
                .frame(width: sizeWidth, height: sizeHeight)
                .cornerRadius(20)
                
            VStack {
                HStack {
                    Selector(mode: .toolbarProgress, action: {_ in })
                    Spacer()
                    Selector(mode: .toolbarControls, action: {_ in })
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, -80)
            
        }
        .padding(paddingEdge, paddingPoint)
    }
}

#Preview {
    ZStack {
        Color.gray
        ToolBar(sizeWidth: 350, sizeHeight: 200, paddingEdge: .top, paddingPoint: 0)
    }.ignoresSafeArea()
}
