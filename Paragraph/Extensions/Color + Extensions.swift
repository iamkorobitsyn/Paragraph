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
    
    static let customGray: Color = .init(r: 86, g: 86, b: 86)
}
