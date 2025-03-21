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
            ZStack {
                Rectangle()
                    .fill(Color.customGrayDeep).opacity(0.9)
                    .cornerRadius(20)
                    
                
                List() {
                    fontStyleCell()
                    FontSizeCell()
                    LineSpacingCell()
                    TransferOfWordsCell()
                    JustificationCell()
                    LeafingModeCell()
                    Rectangle().fill(.clear)
                        .frame(height: 100)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .buttonStyle(.plain)
                }
                .padding(.leading, 20)
                .listStyle(.plain)
          
                HStack {
                    Button(action: { presented.toggle() }) {
                        Image("closeWhite")
                    }
                    Spacer()
                }
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
