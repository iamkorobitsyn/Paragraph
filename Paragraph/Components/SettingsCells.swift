//
//  SettingsCells.swift
//  Paragraph
//
//  Created by Александр Коробицын on 14.03.2025.
//

import Foundation
import SwiftUI

//MARK: - ColorThemeCell

struct ColorThemeCell: View {
    
    @AppStorage("colorThemeIndex") private var index = 0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.customGrayLight)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.3)
                )
                
            HStack() {
                
                Selector(mode: .settingsColorTheme(index), action: { i in
                    index = i
                })
            }
        }
        .frame(width: 210, height: 50)
    }
}



//MARK: - FontStyle

struct fontStyleCell: View {
    
    @AppStorage("fontStyleIndex") private var i: Int = 0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.customGrayLight)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.3)
                )
                
            HStack() {
                Image("fontStyleIcon")
                    .padding(.leading, 10)
                
                Spacer()
                
                ForEach(0..<7, id: \.self) { circleIndex in
                    Circle()
                        .fill(circleIndex == i ? Color.customRed : .gray.opacity(0.5))
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Selector(mode: .settingsPrevAndNext, action: { buttonIndex in
                    
                    if buttonIndex == 0 {
                        if i > 0 { i -= 1 } else { i = 0 }
                    } else {
                        if i < 6 { i += 1 } else { i = 6 }
                    }
                })
                .padding(.trailing, 10)
            }
        }
        .frame(width: 300, height: 50)
    }
}





//MARK: - FontSize

struct FontSizeCell: View {

    @AppStorage("fontSizeIndex") private var i: Int = 0
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.customGrayLight)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.3)
                )
                
            HStack() {
                Image("fontSizeIcon")
                    .padding(.leading, 10)
                
                Spacer()
                
                ForEach(0..<7, id: \.self) { circleIndex in
                    Circle()
                        .fill(circleIndex == i ? Color.customRed : .gray.opacity(0.5))
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Selector(mode: .settingsMinusAndPlus, action: { buttonIndex in
                    
                    if buttonIndex == 0 {
                        if i > 0 { i -= 1 } else { i = 0 }
                    } else {
                        if i < 6 { i += 1 } else { i = 6 }
                    }
                })
                .padding(.trailing, 10)
            }
        }
        .frame(width: 300, height: 50)
    }
}



//MARK: - LineSpacing

struct LineSpacingCell: View {
    
    @State private var spacingIndex = 0
    let spacing = [1, 3, 5, 7, 9, 11, 13]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack() {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white).opacity(0.3)
                    .cornerRadius(0.5)
                    .padding(.top, -4.5)
                    .padding(.trailing, 20)
                HStack() {
                    
                    TabView(selection: $spacingIndex) {
                        ForEach(0..<spacing.count, id: \.self) { index in
                            Text("Aa\nAa\n")
                                .lineSpacing(CGFloat(spacing[spacingIndex]))
                                .foregroundStyle(.white)
                        }
                    }
                    .disabled(true)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    Spacer()
                    
                    Selector(mode: .settingsMinusAndPlus, action: { i in
                        if i == 0 {
                            if spacingIndex > 0 {
                                spacingIndex -= 1
                            } else {
                                spacingIndex = 0
                            }
                        } else {
                            if spacingIndex < spacing.count - 1 {
                                spacingIndex += 1
                            } else {
                                spacingIndex = spacing.count - 1
                            }
                        }
                    })
                        .padding(.trailing, 20)
                }.frame(height: 100)
            }
            
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

//MARK: - TransferOfWords


struct TransferOfWordsCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white).opacity(0.3)
                    .cornerRadius(0.5)
                    .padding(.top, -4.5)
                    .padding(.trailing, 20)
                HStack() {
                    Spacer()
                    Text("Aa -")
                        .foregroundStyle(.white)
                    Spacer()
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: .customGold))
                        .padding(.trailing, 35)
                        .frame(width: 100)
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

//MARK: - Justification

struct JustificationCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white).opacity(0.3)
                    .cornerRadius(0.5)
                    .padding(.top, -4.5)
                    .padding(.trailing, 20)
                HStack() {
                    Spacer()
                    Text("|Aa     Aa|")
                        .foregroundStyle(.white)
                    Spacer()
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: .customGold))
                        .padding(.trailing, 35)
                        .frame(width: 100)
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

//MARK: - LeafingMode


struct LeafingModeCell: View {
    
    @State private var index: Int = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white).opacity(0.3)
                    .cornerRadius(0.5)
                    .padding(.top, -4.5)
                    .padding(.trailing, 20)
                HStack() {
                    Selector(mode: .settingsColorTheme(index), action: { i in
                        index = i
                    })
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

struct testCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Selector(mode: .settingsColorTheme(0), action: { i in })
        }.frame(height: 100)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
        
}

#Preview {
    ZStack {
        Color(.gray)
        fontStyleCell()
    }
    .frame(height: 50)
}
