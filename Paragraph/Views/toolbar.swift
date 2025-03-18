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
    @Binding var settingsPresented: Bool
    @Binding var readerPresented: Bool
    let paddingSelector: CGFloat
    
    @EnvironmentObject private var textService: TextSevice
    
    
    
    var body: some View {
        ZStack() {
            
            Rectangle()
                .fill(Color.white).opacity(0.3)
                .cornerRadius(20)
            
            HStack(alignment: .top) {
                Selector(mode: .toolbarProgress, action: {i in
                    if i == 0 {
                        readerPresented.toggle()
                        textService.setCurrentText()
                    }
                })
                    .padding(.leading, paddingSelector)
                Spacer()
                Selector(mode: .toolbarControls, action: {i in
                    if i == 0 {
                    } else {
                        settingsPresented.toggle()
                    }
                })
                .padding(.trailing, paddingSelector)
            }
            .padding(.top, -80)
            
            HStack {
                Selector(mode: .toolBarBookSort(sortIndex), action: { i in
                    sortIndex = i
                })
                .padding(.leading, paddingSelector)
                Spacer()
                Selector(mode: .toolbarQuotes, action: { i in })
                    .padding(.trailing, paddingSelector)
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    
    ZStack {
        Color.gray
        ToolBarView(settingsPresented: .constant(true),
                    readerPresented: .constant(false),
                    paddingSelector: 40)
            .frame(width: 360, height: 200)
    }.ignoresSafeArea()
        .environmentObject(TextSevice())
        
}
