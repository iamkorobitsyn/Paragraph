//
//  ColorService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 22.03.2025.
//

import Foundation
import SwiftUI

final class ColorService: ObservableObject {
    
    @AppStorage("colorThemeIndex") private var colorThemeIndex: Int = 0
    
    func theme() -> Theme { return Theme(rawValue: colorThemeIndex) ?? .theme0 }
    
    func setTheme(i: Int) { colorThemeIndex = i }
    
    enum Theme: Int {
        case theme0, theme1, theme2, theme3, theme4
        
        var background: Color {
            switch self {
            case .theme0: return Color.readerBackground0
            case .theme1: return Color.readerBackground1
            case .theme2: return Color.readerBackground2
            case .theme3: return Color.readerBackground3
            case .theme4: return Color.readerBackground4
            }
        }
        
        var text: Color {
            switch self {
            case .theme0: return Color.readerText0
            case .theme1: return Color.readerText1
            case .theme2: return Color.readerText2
            case .theme3: return Color.readerText3
            case .theme4: return Color.readerText4
            }
        }
    }
    
}
