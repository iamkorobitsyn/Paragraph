//
//  Main.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct ToolBarView: View {
    
    @AppStorage("sortMode") var sortIndex: Int = 0
    @Binding var readerPresented: Bool
    
    var body: some View {
        if !readerPresented {
            ZStack() {
                Rectangle()
                    .fill(.white).opacity(0.3)
                    .cornerRadius(20)
                
                HStack(alignment: .top) {
                    Selector(mode: .toolbarProgress, action: {i in
                        if i == 0 {
                            readerPresented.toggle()
                        }
                    })
                    .padding(.leading, 40)
                    Spacer()
                    Selector(mode: .toolbarControls, action: {i in
                        if i == 0 {
                        } else {
                        }
                    })
                    .padding(.trailing, 40)
                }
                .padding(.top, -80)
                
                HStack {
                    Selector(mode: .toolBarBookSort(sortIndex), action: { i in
                        sortIndex = i
                    })
                    .padding(.leading, 40)
                    Spacer()
                    Selector(mode: .toolbarQuotes, action: { i in })
                        .padding(.trailing, 40)
                }
                .padding(.top, 100)
            }
        }
    }
}

#Preview {
    
    ZStack {
        Color.gray
        ToolBarView(readerPresented: .constant(false))
            .frame(width: 360, height: 200)
    }.ignoresSafeArea()
        .environmentObject(TextService())
        
}
