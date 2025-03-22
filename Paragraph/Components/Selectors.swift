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
    case settingsColorTheme(Int)
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
        case .settingsColorTheme:
            return CGSize(width: 210, height: 42)
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

        case .settingsColorTheme(let index):
            setButtons(images: ["colorTheme0Icon", "colorTheme1Icon",
                                "colorTheme2Icon", "colorTheme3Icon",
                                "colorTheme4Icon"],
                       selectedIndex: index)
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
                            .frame(width: 12, height: 1)
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
            
        case .toolBarBookSort, .settingsPrevAndNext, .settingsMinusAndPlus:
            Color(.clear)

        case .settingsColorTheme:
            Color(.clear)
        }
    }
}

#Preview {
    ZStack {
        Color(.white)
        Selector(mode: .settingsColorTheme(0), action: { i in
            print(i)})
    }
    
}
