//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import SwiftUI

final class TextService: ObservableObject {
    
    @AppStorage("fontStyleIndex") private var fontIndex = 0
    @AppStorage("fontSizeIndex") private var sizeIndex = 0
    @AppStorage("lineIntervalIndex") private var intervalIndex = 0
    @AppStorage("paddingSizeIndex") private var paddingIndex = 0
    
    let fontList: [FontStyle] = [.charter, .palatino, .baskerville, .courierNew, .helveticaNeue, .helveticaNeueBold]
    let sizeList: [CGFloat] = [15, 20, 25, 30, 35, 40, 45]
    let intervalList: [CGFloat] = [0, 4, 8, 12, 16]
    var paddingList: [CGFloat] = [20, 30, 40, 50, 60]
    
    var regularHypernationWord: Word?
    var hypernationWordOfPreviousPage: Word?
    
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
    
    func setPaddingList(landscape: Bool) {
        if landscape {
            paddingList = [60, 80, 100, 120, 140]
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

}
