//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @Binding var readerPresented: Bool
    
    @State private var content: [String] = []

    @State private var tempWidth: CGFloat = 0
    @State private var width: CGFloat = 0
    @State private var fontSize: CGFloat = 18
    
    @State private var wordsList: [String] = []
    
    
    @EnvironmentObject private var textService: TextSevice
    
    // Функция для расчета списка слов, который помещается в одну строку
    private func createWordList(text: [String], maxWidth: CGFloat, fontSize: CGFloat) -> [String] {
        var tempWidth: CGFloat = 0
        var words: [String] = []
        
        // Проходим по всем словам, вычисляем их ширину и добавляем в список, пока не превышен предел ширины
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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Slider(value: $fontSize, in: 12...36, step: 1)
                        .padding()
                        .onChange(of: fontSize) {
                            // Когда изменяется шрифт, пересчитываем слова
                            textService.setCurrentText()
                            wordsList = createWordList(text: textService.currentBookText, maxWidth: geometry.size.width, fontSize: fontSize)
                        }

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Заголовок")
                                .font(.title)
                                .padding(.bottom, 10)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        
                        
                        // Отображаем список слов
                        HStack(spacing: 0) {
                            ForEach(Array(zip(wordsList.indices, wordsList)), id: \.0) { index, word in
                                if index != 0 {
                                    Spacer(minLength: 0)
                                }
                                if index == wordsList.count - 1 {
                                    Text(word)
                                        .multilineTextAlignment(.trailing)
                                        .background(.clear)
                                        .font(.system(size: fontSize))
                                        .lineLimit(1)
                                } else {
                                    Text(word)
                                        .multilineTextAlignment(.leading)
                                        .background(.clear)
                                        .font(.system(size: fontSize))
                                        .lineLimit(1)
                                }
                                
                            }
                        }
                    }
                }
                
                // Кнопка закрытия
                Button(action: { readerPresented.toggle() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .position(x: 30, y: 30)  // Расположение кнопки
            }
        }
    }
}

// Расширение для вычисления ширины строки
extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(readerPresented: .constant(true))
            .environmentObject(TextSevice())
    }
}
