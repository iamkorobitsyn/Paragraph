//
//  SettingsCells.swift
//  Paragraph
//
//  Created by Александр Коробицын on 14.03.2025.
//

import Foundation
import SwiftUI

struct fontStyleCell: View {
    var body: some View {
            HStack {
                Spacer()
                Selector(mode: .settingsBackAndForward, action: { i in })
                    .padding(.trailing, 20)
            }.frame(height: 100)
    }
}

struct fontScaleCell: View {
    var body: some View {
            HStack {
                Spacer()
                Selector(mode: .settingsLessAndMore, action: { i in })
                    .padding(.trailing, 20)
            }.frame(height: 100)
    }
}

struct testSwitchCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Toggle("Aa -", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .customGold))
                .font(.system(size: 20, weight: .light))
                .padding(.trailing, 20)
        }.frame(height: 100)
    }
}

struct testCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Selector(mode: .settingsLeafing(0), action: { i in })
        }.frame(height: 100)
    }
}
