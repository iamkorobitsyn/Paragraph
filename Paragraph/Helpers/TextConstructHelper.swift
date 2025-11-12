//
//  TextConstructHelper.swift
//  Paragraph
//
//  Created by iamkorobitsyn on 12.11.2025.
//

import Foundation
import SwiftUI

final class TextConstructHelper: ObservableObject {
    
    
    //MARK: ConstructTextLine
    
    func constructTextLine(content: Book, part: Int, block: Int, word: Int,
                 maxWidth: CGFloat, spacerWidth: CGFloat, uIFont: UIFont) -> TextLine {

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
    
    
    //MARK: - GetHightOfString
    
    func heightOfString(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let text = "EnglishtextРусскийтекст中文文本العربية نصहिंदी पाठ한국어 텍스트日本語のテキスト"
        let boundingRect = text.boundingRect(with: CGSize(),
                                             options: .usesLineFragmentOrigin,
                                             attributes: attributes,
                                             context: nil)
        return boundingRect.height
    }
}
