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
    case toolBarBookSort(Int)
    case settingsBackAndForward
    case settingsLessAndMore
    case settingsCancelAndDone
    case settingsLeafing(Int)
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
            
        case .toolbarProgress, .toolbarControls,
             .settingsBackAndForward, .settingsLessAndMore, .settingsCancelAndDone:
            return CGSize(width: 84, height: 42)
        case .toolBarBookSort:
            return CGSize(width: 168, height: 42)
        case .settingsLeafing:
            return CGSize(width: 210, height: 60)
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
            setButtons(images: ["addIcon", "settingsIcon"], selectedIndex: nil)
            
        case .toolBarBookSort(let index):
            setButtons(images: ["bookShelfIcon", "newBooksIcon", "openBooksIcon", "completeBooksIcon"], selectedIndex: index)
    
        case .settingsBackAndForward:
            setButtons(images: ["prevIcon", "nextIcon"], selectedIndex: nil)
            
        case .settingsLessAndMore:
            setButtons(images: ["minusIcon", "plusIcon"], selectedIndex: nil)

        case .settingsCancelAndDone:
            setButtons(images: ["cancelIcon", "checkMarkIcon"], selectedIndex: nil)

        case .settingsLeafing(let index):
            setButtons(images: ["smifflingIcon", "impositionIcon", "leafletIcon"], selectedIndex: index)
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
                            .fill(Color.black)
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
        case .toolbarProgress:
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .cornerRadius(21)

        case .toolbarControls:
            Rectangle()
                .fill(Color(red: 193 / 255, green: 73 / 255, blue: 79 / 255))
                .cornerRadius(21)
            
        case .toolBarBookSort:
            Color(.clear)
        case .settingsBackAndForward, .settingsLessAndMore, .settingsCancelAndDone:
            Rectangle()
                .fill(.clear)
                .cornerRadius(21)
                .overlay(RoundedRectangle(cornerRadius: 21)
                    .stroke(Color.gray, lineWidth: 1))
        case .settingsLeafing:
            Color(.clear)
        }
    }
}

#Preview {
    Selector(mode: .settingsBackAndForward, action: { _ in })
}
