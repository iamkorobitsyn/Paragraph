//
//  ReaderControlsView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

enum DualSelectorMode {
    case progress
    case controls
    case backAndForward
    case lessAndMore
    case cancelAndDone
}

struct DualSelector: View {
    
    @State var mode: DualSelectorMode
    let lAction: () -> Void
    let rAction: () -> Void
    
    
    var body: some View {
        
        ZStack {
            
            switch mode {
            case .progress:
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(21)
                
                HStack(spacing: 0) {
                    SetButton(action: lAction, image: "bookmarkIcon")
                    SetButton(action: rAction, image: "progressIcon")
                }.frame(width: 84, height: 42)
                
            case .controls:
                
                Rectangle()
                    .fill(Color(red: 193 / 255, green: 73 / 255, blue: 79 / 255))
                    .cornerRadius(21)
                
                HStack(spacing: 0) {
                    SetButton(action: lAction, image: "addIcon")
                    SetButton(action: rAction, image: "settingsIcon")
                }
                
            case .backAndForward, .lessAndMore, .cancelAndDone:
                
                Rectangle()
                    .fill(.clear)
                    .cornerRadius(21)
                    .overlay(RoundedRectangle(cornerRadius: 21)
                        .stroke(Color.gray, lineWidth: 1))
                
                if .backAndForward == mode {
                    HStack(spacing: 0) {
                        SetButton(action: lAction, image: "prevIcon")
                        SetButton(action: rAction, image: "nextIcon")
                    }
                }
                
                if .lessAndMore == mode {
                    HStack(spacing: 0) {
                        SetButton(action: lAction, image: "minusIcon")
                        SetButton(action: rAction, image: "plusIcon")
                    }
                }
                
                if .cancelAndDone == mode {
                    HStack(spacing: 0) {
                        SetButton(action: lAction, image: "cancelIcon")
                        SetButton(action: rAction, image: "checkMarkIcon")
                    }
                }
            }
        }
        .frame(width: 84, height: 42)
    }
        
}

struct SetButton: View {
    
    let action: () -> Void
    let image: String
    
    var body: some View {
        Button(action: action) {
            Image(image)
        }
    }
}


#Preview {
    DualSelector(mode: .progress, lAction: {}, rAction: {})
}
