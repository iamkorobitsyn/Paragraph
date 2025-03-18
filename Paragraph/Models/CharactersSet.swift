//
//  CharactersSet.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import SwiftUI

// Структура для хранения массивов гласных и согласных букв
struct CharSets {
    
    // Массив гласных букв
    static let vowels: [Character] = [
        // Русский язык
        "а", "е", "ё", "и", "о", "у", "ы", "э", "ю", "я",
        
        // Английский язык
        "a", "e", "i", "o", "u",
        
        // Французский язык
        "à", "â", "æ", "é", "è", "ê", "ë", "í", "ï", "î", "ó", "ô", "œ", "ù", "û", "ü",
        
        // Испанский язык
        "á", "é", "í", "ó", "ú", "ü", "ñ", "á", "é", "í", "ó", "ú",
        
        // Немецкий язык
        "ä", "ö", "ü", "é", "è", "á", "í", "ó", "ú",
        
        // Итальянский язык
        "à", "è", "é", "ì", "í", "ò", "ó", "ù",
        
        // Португальский язык
        "á", "à", "ã", "é", "ê", "í", "ó", "õ", "ô", "ú",
        
        // Другие языки с диакритиками
        "å", "ø", "ø", "æ", "ç", "î", "ó", "ú", "č", "š", "ř", "ž"
    ]
    
    // Массив согласных букв
    static let consonants: [Character] = [
        // Русский язык
        "б", "в", "г", "д", "ж", "з", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ",
        
        // Английский язык
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z",
        
        // Французский язык
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z",
        "ç", "à", "é", "ù", "â", "ê", "ï", "î", "ô", "ü", "œ",
        
        // Испанский язык
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z",
        "ñ", "ll", "ch", "rr",
        
        // Немецкий язык
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z",
        "ß", "ä", "ö", "ü", "ç", "h", "j", "l", "m", "n",
        
        // Итальянский язык
        "b", "c", "d", "f", "g", "h", "l", "m", "n", "p", "q", "r", "s", "t", "v", "z",
        
        // Португальский язык
        "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z",
        "ç", "lh", "nh", "rr", "ss", "x",
        
        // Другие языки с диакритиками
        "č", "š", "ř", "ž", "č", "š", "ž", "đ", "ĺ", "ñ"
    ]
}
