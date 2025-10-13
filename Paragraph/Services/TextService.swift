//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine
import SwiftUI

final class TextService: ObservableObject {
    
    lazy var content = Book(title: "Цирк семьи Пайло",
                            author: "Уилл Элиот",
                            coverImage: "",
                            status: .open,
                            progress: 58.5,
                            bookParts: [
                                .init(textBlocks:
                                            [TextBlock(text: textConvert(text: "Title"), mode: .title)]),
                                    .init(textBlocks:
                                            [TextBlock(text: textConvert(text: "Страница 1"), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "2 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "5 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph)]),
                                
                                        .init(textBlocks:
                                                [TextBlock(text: textConvert(text: "Страница 2"), mode: .paragraph),
                                                 TextBlock(text: textConvert(text: "2 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                                 TextBlock(text: textConvert(text: "4 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                                 ]),
                                    
                                    .init(textBlocks:
                                            [TextBlock(text: textConvert(text: "Страница 3"), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "2 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "3 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "4 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph),
                                             TextBlock(text: textConvert(text: "5 Моя мама стояла всего в семи метрах от моего такси и копалась в мусорном бачке. На плечи она накинула какие-то тряпки, чтобы было теплее, и рядом с ней играла ее собака – помесь терьера и дворняжки черно-белой расцветки. Я прекрасно знала мамины жесты и мимику – исследуя содержимое помойки, она наклоняла голову и слегка оттопыривала нижнюю губу в поисках «сокровищ», которые вытаскивала из бачка. Когда она находила что-нибудь, что ей нравилось, ее глаза расширялись от радости. Ее волосы поседели и висели клочьями, глаза запали, но, тем не менее, это была моя мама, которую я прекрасно помнила, которая ныряла в море с высоких скал, рисовала в пустыне и читала наизусть Шекспира. У нее были все те же скулы, хотя кожа на лице была в старческих пятнах от солнца и ветра. Всем прохожим она представлялась обычной бездомной, которых в Нью-Йорке тысячи."), mode: .paragraph)]),
                            ] )
                                                   
    
    
    
    
    func textConvert(text: String) -> [Word] {

        var wordList: [Word] = []
        var tempText: [Character] = []
        
        for (index, char) in text.enumerated() {
            if char != " " {
                tempText.append(char)
            }

            if (char == " " && !tempText.isEmpty) || (index == text.count - 1 && !tempText.isEmpty) {
                let word = Word(id: wordID, text: String(tempText))
                wordList.append(word)
                wordID += 1
                tempText = []
            }
        }
        
        return wordList
    }
    
   
    
    
    var wordID: Int = 0
    
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

    func heightOfString(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let text = "EnglishtextРусскийтекст中文文本العربية نصहिंदी पाठ한국어 텍스트日本語のテキスト"
        let boundingRect = text.boundingRect(with: CGSize(),
                                             options: .usesLineFragmentOrigin,
                                             attributes: attributes,
                                             context: nil)
        
        return boundingRect.height
    }
    
    //MARK: - GetTextLine
    
    func getLine(content: Book, part: Int, block: Int, word: Int, maxWidth: CGFloat, spacerWidth: CGFloat, uIFont: UIFont) -> TextLine {

        var tempWidth: CGFloat = 0
        var words: [Word] = []
        let mode = content.bookParts[part].textBlocks[block].mode

        var endPart = part
        var endBlock = block
        var endWord = word
        
        var startFlag = false
        var endFlag = false
        var endContent = false
        
        for i in word..<content.bookParts[part].textBlocks[block].text.count {
            
            //adding spacer
            
            if i == 0 && mode == .paragraph {
                startFlag.toggle()
                tempWidth += 20
            }
            //adding word

            let wordWidth = content.bookParts[part].textBlocks[block].text[i].text.widthOfString(usingFont: uIFont)

            if tempWidth + wordWidth + spacerWidth <= maxWidth || words.count == 0 {
                
                words.append(content.bookParts[part].textBlocks[block].text[i])
                tempWidth += (spacerWidth + wordWidth)
                
                
                
                
                if i != content.bookParts[part].textBlocks[block].text.count - 1 {
                    endWord += 1
                } else {
                  if endBlock != content.bookParts[endPart].textBlocks.count - 1 {
                    endWord = 0
                    endBlock += 1
                      endFlag = true
                    break
                } else if endPart != content.bookParts.count - 1 {
                    endPart += 1
                    endBlock = 0
                    endWord = 0
                    endContent = true
                    break
                } else if endPart == content.bookParts.count - 1 {
                    endContent = true
                    break
                }
                }
                
            } else {
                break
            }
        }
 
        return TextLine(text: words, mode: mode,
                        endPart: endPart, endBlock: endBlock, endWord: endWord,
                        startFlag: startFlag, endFlag: endFlag, endContent: endContent, height: heightOfString(font: uIFont))
    }
}
