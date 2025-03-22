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
    static let customGrayLight: Color = .init(r: 216, g: 216, b: 216)
    static let customGold: Color = .init(r: 248, g: 166, b: 25)
}
