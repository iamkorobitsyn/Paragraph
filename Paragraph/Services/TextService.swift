//
//  TextService.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Combine

final class TextSevice: ObservableObject {
    
    private let content: [String] = ["Начался ", "и ", "закончился ", "шестичасовой ", "наплыв ", "гостей... ", "Начался ", "и ", "закончился ", "шестичасовой ", "наплыв ", "гостей ", "Начался ", "и ", "закончился ", "шестичасовой ", "наплыв ", "гостей ", "Начался ", "и ", "закончился ", "шестичасовой ", "наплыв ", "гостей ", "Начался ", "и ", "закончился ", "шестичасовой ", "наплыв ", "гостей "]
    
    var currentBookText: [String] = []
    
    func setCurrentText() {
        currentBookText = content
    }
    
}
