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
            VStack() {
                Spacer()
                HStack {
                    Spacer()
                    List() {
                        Rectangle().fill(.clear)
                            .frame(height: 100)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .buttonStyle(.plain)
                        ColorThemeCell()
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .buttonStyle(.plain)
                            .padding([.top, .bottom], 2)
                            .listRowBackground(Color.clear)
                        fontStyleCell()
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .buttonStyle(.plain)
                            .padding([.top, .bottom], 2)
                            .listRowBackground(Color.clear)
                        FontSizeCell()
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .buttonStyle(.plain)
                            .padding([.top, .bottom], 2)
                            .listRowBackground(Color.clear)
                    }
                    .frame(width: 300, height: 400)
                    .padding(.trailing, 10)
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
    }
   
}
