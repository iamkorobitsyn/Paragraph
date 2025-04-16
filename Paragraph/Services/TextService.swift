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
    
    lazy var content = Book(title: "Цирк семьи Пайло",
                       author: "Уилл Элиот",
                       coverImage: "",
                       status: .open,
                       progress: 58.5,
                       textBlocks: [TextBlock(text: textConvert(text: "Что может быть страшнее клоуна за пределами цирка? Только сам цирк, в котором клоуны-убийцы воюют с акробатами, а хозяева ставят эксперименты на своих артистах. И только такой мир, полный кошмаров и гротеска, может заставить обычного недотепу-консьержа в буквальном смысле бороться с самим собой – воевать со своим клоунским альтер-эго не на жизнь, а на смерть. Автор романа – Уилл Эллиотт – не понаслышке знает, что такое раздвоение личности, хотя и не считает роман автобиографическим. Тем не менее щупальца шизофрении так тихо, но властно проникают в сознание, что читателю следует быть уверенным в собственном душевном равновесии, прежде чем приниматься за книгу."),
                                        mode: .paragraph),
                              TextBlock(text: textConvert(text: "Что сразу насторожило Джейми – так это взгляд клоуна, изумленный блеск, будто он впервые очутился в этом мире, словно машина Джейми – первое, что он увидел. Казалось, существо только-только вылупилось из огромного яйца, доковыляло до дороги и застыло там, как манекен в витрине магазина. Цветастая рубаха, заправленная в штаны, едва удерживала обвисший живот, руки плотно прижаты к бокам, а ладони, обтянутые белыми перчатками, сжаты в кулаки. Под мышками расплывались пятна от пота. Клоун таращился на него через ветровое стекло нелепыми удивленными глазами, потом интерес пропал, и он отвернулся от машины, едва не задавившей его насмерть."),
                                        mode: .paragraph),
                              TextBlock(text: textConvert(text: "Часы на приборной панели отсчитали десятую секунду с того момента, как Джейми вдарил по тормозам. Он чувствовал запах жженой резины. За все время, что он провел за рулем, мир лишился двух кошек, одного фазана, и вот теперь к этому списку едва не добавился совершенно одуревший человек. В голове у Джейми пронеслись все те напасти, что могли бы свалиться на него, не затормози он вовремя: судебные процессы, обвинения, бессонные ночи и чувство вины до конца жизни. На него накатил приступ гнева, как это бывает у водителей, – он опустил стекло и заорал:"),
                                        mode: .paragraph)               
                       ])
    
    
    @AppStorage("fontStyleIndex") private var fontIndex = 0
    @AppStorage("fontSizeIndex") private var sizeIndex = 0
    @AppStorage("lineIntervalIndex") private var intervalIndex = 0
    @AppStorage("paddingSizeIndex") private var paddingIndex = 0
    
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
    
    
    func getLine(content: Book, block: Int, word: Int, maxWidth: CGFloat, uIFont: UIFont) -> TextLine {
        var tempWidth: CGFloat = 0
        var words: [Word] = []
        var mode: TextMode = .paragraph
        let height = heightOfString(font: uIFont)
        
        var isStartOfBlock = false
        var isEndOfBlock = false
        var isEndOfContent = false
        
        var tempBlock = block
        var tempWord = word
        
        let currentBlock = content.textBlocks[tempBlock]
            mode = currentBlock.mode
            
            for currentWord in tempWord..<currentBlock.text.count {
                
                //adding spacer
                
                if currentWord == 0 && currentBlock.mode == .paragraph {
                    tempWidth += 20
                    isStartOfBlock = true
                }
                
                //adding word
                
                let wordWidth = currentBlock.text[currentWord].text.widthOfString(usingFont: uIFont)
                
                if tempWidth + wordWidth <= maxWidth || words.count == 0 {
                    words.append(currentBlock.text[currentWord])
                        tempWidth += wordWidth
                        if currentWord != currentBlock.text.count - 1 {
                            tempWord += 1
                        } else {
                            tempWord = 0
                            isEndOfBlock = true
                            if tempBlock != content.textBlocks.count - 1 {
                                tempBlock += 1
                            } else {
                                isEndOfContent = true
                            }
                            
                        }
                } else {
                    return TextLine(words, mode, height, isStartOfBlock, isEndOfBlock, isEndOfContent, tempBlock, tempWord)
                }
            }
        return TextLine(words, mode, height, isStartOfBlock, isEndOfBlock, isEndOfContent, tempBlock, tempWord)
    }
}
