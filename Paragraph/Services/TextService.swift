//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine
import SwiftUI

final class TextService: ObservableObject {
    
    @AppStorage("fontStyleIndex") private var fontIndex = 0
    @AppStorage("fontSizeIndex") private var sizeIndex = 0
    @AppStorage("lineIntervalIndex") private var intervalIndex = 0
    @AppStorage("paddingSizeIndex") private var paddingIndex = 0
    
    @Published private var currentBlockIndex: Int = 0
    @Published private var currentWordIndex: Int = 0
    
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
    
    func getPadding() -> CGFloat
    { return paddingList[paddingIndex] }
    
    func getInterval() -> CGFloat
    { return intervalList[intervalIndex] }
    
    func getSize() -> CGFloat
    { return sizeList[sizeIndex] }
    
    func getFont() -> Font
    { return FontStyle(rawValue: fontIndex)?.getFont(size: getSize()) ?? FontStyle.charter.getFont(size: getSize()) }
    
    func getUIFont() -> UIFont
    { return FontStyle(rawValue: fontIndex)?.getUIFont(size: getSize()) ?? FontStyle.charter.getUIFont(size: getSize()) }


    func heightOfString(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let text = "EnglishtextРусскийтекст中文文本العربية نصहिंदी पाठ한국어 텍스트日本語のテキスト"
        let boundingRect = text.boundingRect(with: CGSize(),
                                             options: .usesLineFragmentOrigin,
                                             attributes: attributes,
                                             context: nil)
        
        return boundingRect.height
    }
    

    func updateProgress(content: Book) {
        currentBlockIndex = content.progressBlock
        currentWordIndex = content.progressWord
    }
    
    func getLine(content: Book, maxWidth: CGFloat, font: UIFont) -> [String] {
        var tempWidth: CGFloat = 0
        var words: [String] = []
        
        
        for blockIndex in currentBlockIndex..<content.text.count {
            let block = content.text[blockIndex]
            currentBlockIndex = blockIndex
            
            for wordIndex in currentWordIndex..<block.words.count {
                let wordWidth = block.words[wordIndex].widthOfString(usingFont: font)
                
                if tempWidth + wordWidth <= maxWidth {
                    words.append(block.words[wordIndex])
                    tempWidth += wordWidth
                    if wordIndex != block.words.count - 1 {
                        currentWordIndex = wordIndex
                        currentWordIndex += 1
                    } else {
                        currentWordIndex = 0
                    }
                    
                } else {
                    
                    return words
                }
            }
        }
        return words
    }
}
