//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine
import SwiftUI

final class TextService: ObservableObject {
    
    @AppStorage("fontStyleIndex") private var fontStyleIndex = 0
    
    @AppStorage("fontSizeIndex") private var fontSizeIndex = 0
    private let sizeList: [CGFloat] = [15, 20, 25, 30, 35, 40, 45]
    
    
    func getSize() -> CGFloat { return sizeList[fontSizeIndex] }
    
    func getFont() -> Font {
        return FontStyle(rawValue: fontStyleIndex)?.getFont(size: getSize()) ?? FontStyle.timesNewRoman.getFont(size: 15)
    }
    
    func getUIFont() -> UIFont {
        return FontStyle(rawValue: fontStyleIndex)?.getUIFont(size: getSize()) ?? FontStyle.timesNewRoman.getUIFont(size: 15)
    }
    
    enum FontStyle: Int {
        case timesNewRoman, georgia, palatino, serifSistem, sanFrancisco, helveticaNeue, Avenir
        
        func getFont(size: CGFloat) -> Font {
            switch self {
            case .timesNewRoman:
                return .custom("Times New Roman", size: size)
            case .georgia:
                return .custom("Georgia", size: size)
            case .palatino:
                return .custom("Palatino", size: size)
            case .serifSistem:
                return .custom("Baskerville", size: size)
            case .sanFrancisco:
                return .custom("Helvetica Neue", size: size)
            case .helveticaNeue:
                return .custom("Verdana", size: size)
            case .Avenir:
                return .custom("Roboto", size: size)
            }
        }
        
        func getUIFont(size: CGFloat) -> UIFont {
            switch self {
            case .timesNewRoman:
                return  UIFont(name: "Times New Roman", size: size) ?? .systemFont(ofSize: size)
            case .georgia:
                return  UIFont(name: "Georgia", size: size) ?? .systemFont(ofSize: size)
            case .palatino:
                return  UIFont(name: "Palatino", size: size) ?? .systemFont(ofSize: size)
            case .serifSistem:
                return  UIFont(name: "Baskerville", size: size) ?? .systemFont(ofSize: size)
            case .sanFrancisco:
                return  UIFont(name: "Helvetica Neue", size: size) ?? .systemFont(ofSize: size)
            case .helveticaNeue:
                return  UIFont(name: "Verdana", size: size) ?? .systemFont(ofSize: size)
            case .Avenir:
                return  UIFont(name: "Roboto", size: size) ?? .systemFont(ofSize: size)
            }
        }
    }
    


    
    
    func createWordList(text: [String], maxWidth: CGFloat, font: UIFont) -> [String] {
        var tempWidth: CGFloat = 0
        var words: [String] = []
        
        for word in text {
            let wordWidth = word.widthOfString(usingFont: font)
            
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
