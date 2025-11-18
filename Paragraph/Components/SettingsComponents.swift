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
    @EnvironmentObject private var service: TextTypographyHelper
    
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
                
                ForEach(0..<service.fontList.count, id: \.self) { circleIndex in
                    Circle()
                        .fill(circleIndex == i ? Color.customRed : .gray.opacity(0.5))
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Selector(mode: .settingsPrevAndNext, action: { buttonIndex in
                    
                    if buttonIndex == 0 {
                        if i > 0 { i -= 1 } else { i = 0 }
                    } else {
                        if i < service.fontList.count - 1 { i += 1 }
                        else { i = service.fontList.count - 1 }
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
    @EnvironmentObject private var service: TextTypographyHelper
    
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
                        if i < service.sizeList.count - 1 { i += 1 }
                        else { i = service.sizeList.count - 1 }
                    }
                })
                .padding(.trailing, 10)
            }
        }
        .frame(width: 300, height: 50)
    }
}



//MARK: - LineInterval

struct LineIntervalCell: View {
    
    @AppStorage("lineIntervalIndex") private var i: Int = 0
    @EnvironmentObject private var service: TextTypographyHelper
    
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
                Image("lineIntervalIcon")
                    .padding(.leading, 10)
                
                Spacer()
                
                ForEach(0..<service.intervalList.count, id: \.self) { circleIndex in
                    Circle()
                        .fill(circleIndex == i ? Color.customRed : .gray.opacity(0.5))
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Selector(mode: .settingsMinusAndPlus, action: { buttonIndex in
                    
                    if buttonIndex == 0 {
                        if i > 0 { i -= 1 } else { i = 0 }
                    } else {
                        if i < service.intervalList.count - 1 { i += 1 }
                        else { i = service.intervalList.count - 1 }
                    }
                })
                .padding(.trailing, 10)
            }
        }
        .frame(width: 300, height: 50)
    }
}

// MARK: - LineInterval

struct PaddingSizeCell: View {
    
    @AppStorage("paddingSizeIndex") private var i: Int = 0
    @EnvironmentObject private var service: TextTypographyHelper
    
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
                Image("paddingIcon")
                    .padding(.leading, 10)
                
                Spacer()
                
                ForEach(0..<service.paddingList.count, id: \.self) { circleIndex in
                    Circle()
                        .fill(circleIndex == i ? Color.customRed : .gray.opacity(0.5))
                        .frame(width: 5, height: 5)
                }
                
                Spacer()
                
                Selector(mode: .settingsMinusAndPlus, action: { buttonIndex in
                    
                    if buttonIndex == 0 {
                        if i > 0 { i -= 1 } else { i = 0 }
                    } else {
                        if i < service.paddingList.count - 1 { i += 1 }
                        else { i = service.paddingList.count - 1 }
                    }
                })
                .padding(.trailing, 10)
            }
        }
        .frame(width: 300, height: 50)
    }
}

//MARK: - TransferOfWords


struct TransferOfWordsCell: View {
    
    @AppStorage("wordsTransfer") private var transferIs: Bool = true
    
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
                Image("wordTransferIcon")
                    .padding(.leading, 10)
                
                Spacer()
                Toggle("", isOn: $transferIs)
                    .toggleStyle(SwitchToggleStyle(tint: .customGold))
                    .padding(.trailing, 25)
            }
        }
        .frame(width: 150, height: 50)
    }
}



#Preview {
    ZStack {
        Color(.gray)
        TransferOfWordsCell()
            .environmentObject(TextTypographyHelper())
    }
    .frame(height: 50)
}
