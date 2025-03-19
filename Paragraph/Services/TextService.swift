//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine
import Foundation

final class TextService: ObservableObject {
    
    
    func createWordList(text: [String], maxWidth: CGFloat, fontSize: CGFloat) -> [String] {
        var tempWidth: CGFloat = 0
        var words: [String] = []
        
        for word in text {
            let wordWidth = word.widthOfString(usingFont: .systemFont(ofSize: fontSize))
            
            if tempWidth + wordWidth <= maxWidth {
                words.append(word)
                tempWidth += wordWidth
            } else {
                break
            }
        }
        return words
    }
}
