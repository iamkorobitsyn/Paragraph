//
//  Main.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct ToolBarView: View {
    
    let sizeWidth: CGFloat
    let sizeHeight: CGFloat
    let paddingEdge: Edge.Set
    let paddingPoint: CGFloat
    
    @AppStorage("sortMode") var sortIndex: Int = 0
    @State private var sortLabel: String = "All books"
    
    @Binding var toolBarIsPresented: Bool
    
    var body: some View {
        ZStack() {
            
            Rectangle()
                .fill(Color.white).opacity(0.3)
                .frame(width: sizeWidth, height: sizeHeight)
                .cornerRadius(20)
                
            
            
            HStack {
                Selector(mode: .toolbarProgress, action: {i in })
                    .padding(.trailing, sizeWidth / 5)
                Selector(mode: .toolbarControls, action: {i in
                    if i == 1 { toolBarIsPresented.toggle() }
                })
                    .padding(.leading, sizeWidth / 5)
            }
            .padding(.top, -80)
            
            HStack {
                Selector(mode: .toolBarBookSort(sortIndex), action: { i in
                    sort(index: i)
                })
                    .padding(.trailing, 20)
                Text(sortLabel)
                    .foregroundStyle(Color.black).opacity(0.8)
                    .font(.title3)
                    .frame(width: 120, height: 50)
            }
            .padding(.top, 100)
            
        }
        .padding(paddingEdge, paddingPoint)
        
        .onAppear() {
            sort(index: sortIndex)
        }
    }
    
    private func sort(index: Int) {
        sortIndex = index
        
        switch index {
        case 0:
            sortLabel = "All books"
        case 1:
            sortLabel = "Closed books"
        case 2:
            sortLabel = "Open books"
        case 3:
            sortLabel = "Completed books"
        default:
            break
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        ToolBarView(sizeWidth: 350, sizeHeight: 200, paddingEdge: .top, paddingPoint: 0, toolBarIsPresented: .constant(true))
    }.ignoresSafeArea()
}
