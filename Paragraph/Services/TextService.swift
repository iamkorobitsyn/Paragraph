//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine
import SwiftUI

final class TextService: ObservableObject {
    
    var wordID: Int = 0
    
    func textConvert(text: String) -> [Word] {
        var wordList: [Word] = []
        var tempText: [Character] = []
        
        text.forEach { char in
            if char != " " {
                tempText.append(char)
            } else {
                tempText.append(char)
                let word = Word(id: wordID, text: String(tempText))
                wordList.append(word)
                wordID += 1
                tempText = []
            }
        }
        return wordList
    }
    
    @AppStorage("fontStyleIndex") private var fontIndex = 0
    @AppStorage("fontSizeIndex") private var sizeIndex = 0
    @AppStorage("lineIntervalIndex") private var intervalIndex = 0
    @AppStorage("paddingSizeIndex") private var paddingIndex = 0
    
    @Published var currentBlockIndex: Int = 0
    @Published var currentWordIndex: Int = 0
    
    let fontList: [FontStyle] = [.charter, .palatino, .baskerville, .courierNew, .helveticaNeue, .helveticaNeueBold]
    let sizeList: [CGFloat] = [15, 20, 25, 30, 35, 40, 45]
    let intervalList: [CGFloat] = [0, 4, 8, 12, 16]
    var paddingList: [CGFloat] = [20, 30, 40, 50, 60]
    
    enum FontStyle: Int {
        case charter, palatino, baskerville, courierNew, helveticaNeue, helveticaNeueBold
        
        func getFont(size: CGFloat) -> Font {
            switch self {
            case .charter:
                return .custom("Charter", size: size)
            case .palatino:
                return .custom("Palatino", size: size)
            case .baskerville:
                return .custom("Baskerville", size: size)
            case .courierNew:
                return .custom("Courier New", size: size)
            case .helveticaNeue:
                return .custom("Helvetica Neue", size: size)
            case .helveticaNeueBold:
                return .custom("Helvetica Neue Bold", size: size)
            }
        }
        
        func getUIFont(size: CGFloat) -> UIFont {
            switch self {
            case .charter:
                return  UIFont(name: "Charter", size: size) ?? .systemFont(ofSize: size)
            case .palatino:
                return  UIFont(name: "Palatino", size: size) ?? .systemFont(ofSize: size)
            case .baskerville:
                return  UIFont(name: "Baskerville", size: size) ?? .systemFont(ofSize: size)
            case .courierNew:
                return  UIFont(name: "Courier New", size: size) ?? .systemFont(ofSize: size)
            case .helveticaNeue:
                return  UIFont(name: "Helvetica Neue", size: size) ?? .systemFont(ofSize: size)
            case .helveticaNeueBold:
                return  UIFont(name: "Helvetica Neue Bold", size: size) ?? .systemFont(ofSize: size)
            }
        }
    }
    
    func setPaddingList(device: UIUserInterfaceIdiom) {
        if device == .pad {
            paddingList = [60, 90, 120, 150, 180]
        } else {
            paddingList = [30, 40, 50, 60, 70]
        }
    }
    
    
    func getInterval() -> CGFloat
    { return intervalList[intervalIndex] }
    
    func getPadding() -> CGFloat
    { return paddingList[paddingIndex] }
    
    func getFont() -> Font
    { return FontStyle(rawValue: fontIndex)?.getFont(size: getFontSize()) ?? FontStyle.charter.getFont(size: getFontSize()) }
    
    func getUIFont() -> UIFont
    {return FontStyle(rawValue: fontIndex)?.getUIFont(size: getFontSize()) ?? FontStyle.charter.getUIFont(size: getFontSize()) }
    
    func getFontSize() -> CGFloat
    { return sizeList[sizeIndex] }

    func heightOfString(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let text = "EnglishtextРусскийтекст中文文本العربية نصहिंदी पाठ한국어 텍스트日本語のテキスト"
        let boundingRect = text.boundingRect(with: CGSize(),
                                             options: .usesLineFragmentOrigin,
                                             attributes: attributes,
                                             context: nil)
        
        return boundingRect.height
    }
    
    
    func getLine(content: Book, maxWidth: CGFloat, uIFont: UIFont) -> TextLine {
        var tempWidth: CGFloat = 0
        var words: [Word] = []
        var mode: TextMode = .paragraph
        let height = heightOfString(font: uIFont)
        
        var isStartOfBlock = false
        var isEndOfBlock = false
        
        
        let block = content.text[currentBlockIndex]
            mode = block.mode
            
            for wordIndex in currentWordIndex..<block.text.count {
                
                //adding spacer
                
                if wordIndex == 0 && block.mode == .paragraph {
                    tempWidth += 20
                    isStartOfBlock = true
                }
                
                //adding word
                
                let wordWidth = block.text[wordIndex].text.widthOfString(usingFont: uIFont)
                
                if tempWidth + wordWidth <= maxWidth || words.count == 0 {
                    words.append(block.text[wordIndex])
                        tempWidth += wordWidth
                        if wordIndex != block.text.count - 1 {
                            currentWordIndex = wordIndex + 1
                        } else {
                            currentWordIndex = 0
                            isEndOfBlock = true
                            if currentBlockIndex < content.text.count - 1 {
                                currentBlockIndex += 1
                            }
                            
                        }
                } else {
                    return TextLine(words, mode, height, isStartOfBlock, isEndOfBlock)
                }
            }
        return TextLine(words, mode, height, isStartOfBlock, isEndOfBlock)
    }
}
