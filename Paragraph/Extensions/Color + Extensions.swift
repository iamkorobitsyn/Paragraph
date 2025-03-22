//
//  Color + Extensions.swift
//  Paragraph
//
//  Created by Александр Коробицын on 13.03.2025.
//

import Foundation
import SwiftUI

extension Color {
    
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255)
    }
    
    static let customGrayDeep: Color = .init(r: 86, g: 86, b: 86)
    static let customGrayLight: Color = .init(r: 234, g: 234, b: 234)
    static let customGold: Color = .init(r: 248, g: 166, b: 25)
    static let customRed: Color = .init(r: 193, g: 73, b: 79)
    
    static let readerBackground0: Color = .init(r: 255, g: 255, b: 255)
    static let readerBackground1: Color = .init(r: 238, g: 237, b: 237)
    static let readerBackground2: Color = .init(r: 74, g: 74, b: 76)
    static let readerBackground3: Color = .init(r: 254, g: 247, b: 235)
    static let readerBackground4: Color = .init(r: 253, g: 239, b: 216)
    
    static let readerText0: Color = .init(r: 0, g: 0, b: 0)
    static let readerText1: Color = .init(r: 32, g: 28, b: 28)
    static let readerText2: Color = .init(r: 170, g: 170, b: 178)
    static let readerText3: Color = .init(r: 19, g: 18, b: 0)
    static let readerText4: Color = .init(r: 46, g: 46, b: 46)
}
