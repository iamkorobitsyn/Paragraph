//
//  ReaderControlsView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

enum SelectorMode {
    case toolbarProgress
    case toolbarControls
    case toolbarQuotes
    case toolBarBookSort(Int)
    case settingsPrevAndNext
    case settingsMinusAndPlus
    case settingsLeafing(Int)
    case readerControls
}

//MARK: - Selector

struct Selector: View {
    
    var mode: SelectorMode
    let action: (Int) -> Void
    
    var body: some View {
        
        ZStack() {
            
            SelectorBackground(mode: mode)
            SelectorContent(mode: mode, action: action)

        }.frame(width: getFrameSize().width, height: getFrameSize().height)
        
    }
    private func getFrameSize() -> CGSize {
        switch mode {
        case .toolbarQuotes:
            return CGSize(width: 42, height: 42)
        case .toolbarProgress, .toolbarControls,
             .settingsPrevAndNext, .settingsMinusAndPlus:
            return CGSize(width: 84, height: 42)
        case .toolBarBookSort:
            return CGSize(width: 168, height: 42)
        case .settingsLeafing:
            return CGSize(width: 210, height: 60)
        case .readerControls:
            return CGSize(width: 84, height: 42)
        }
    }
}

//MARK: - selectorContent

struct SelectorContent: View {
    
    var mode: SelectorMode
    let action: (Int) -> Void
    
    
    var body: some View {
        switch mode {
            
        case .toolbarProgress:
            setButtons(images: ["bookmarkIcon", "progressIcon"], selectedIndex: nil)
            
        case .toolbarControls:
            setButtons(images: ["addIcon", "cloudIcon"], selectedIndex: nil)
            
        case .toolbarQuotes:
            setButtons(images: ["quotesIcon"], selectedIndex: nil)
            
        case .toolBarBookSort(let index):
            setButtons(images: ["bookshelfIcon", "newBooksIcon", "openBooksIcon", "completedBooksIcon"], selectedIndex: index)
    
        case .settingsPrevAndNext:
            setButtons(images: ["prevIcon", "nextIcon"], selectedIndex: nil)
            
        case .settingsMinusAndPlus:
            setButtons(images: ["minusIcon", "plusIcon"], selectedIndex: nil)

        case .settingsLeafing(let index):
            setButtons(images: ["settingsSmiffling", "settingsImposition", "settingsLeaflet"], selectedIndex: index)
        case .readerControls:
            setButtons(images: ["textStyleIcon", "closeWhiteIcon"], selectedIndex: nil)
        }
    }
    
    //MARK: - SetButtons
    
    private func setButtons(images: [String], selectedIndex: Int?) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<images.count, id: \.self) { index in
                ZStack(alignment: .bottom) {
                    Button(action: {action(index)}) {
                        Image(images[index])
                    }
                    
                    if selectedIndex != nil && selectedIndex == index {
                        Rectangle()
                            .fill(Color.customGrayDeep)
                            .frame(width: 20, height: 1)
                    }
                }
            }
        }
    }
}



//MARK: - BakgroundView

struct SelectorBackground: View {
    
    var mode: SelectorMode
    
    var body: some View {
        switch mode {
        case .toolbarProgress, .toolbarQuotes:
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .cornerRadius(14)
        case .readerControls:
            Rectangle()
                .fill(Color.customGold)
                .cornerRadius(14)

        case .toolbarControls:
            Rectangle()
                .fill(Color(red: 193 / 255, green: 73 / 255, blue: 79 / 255))
                .cornerRadius(14)
            
        case .toolBarBookSort:
            Color(.clear)
        case .settingsPrevAndNext, .settingsMinusAndPlus:
            Rectangle()
                .fill(.gray)
                .cornerRadius(14)
//                .overlay(RoundedRectangle(cornerRadius: 21)
//                    .stroke(Color.gray, lineWidth: 1))
        case .settingsLeafing:
            Color(.clear)
        }
    }
}

#Preview {
    ZStack {
        Selector(mode: .readerControls, action: { i in
            print(i)})
    }
    
}
