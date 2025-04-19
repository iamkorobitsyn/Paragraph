//
//  String + Extansions.swift
//  Paragraph
//
//  Created by Александр Коробицын on 19.03.2025.
//

import Foundation
import SwiftUI

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .kern: 0]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
