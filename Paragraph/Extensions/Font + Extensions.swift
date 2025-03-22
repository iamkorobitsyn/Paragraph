//
//  Font + Extansions.swift
//  Paragraph
//
//  Created by Александр Коробицын on 22.03.2025.
//

//import UIKit
//import SwiftUI
//
//extension Font {
//    // Преобразуем Font в UIFont
//    func toUIFont() -> UIFont? {
//        switch self {
//        case .custom(let title, let size, let weight):  // Учитываем вес шрифта
//            // Пытаемся получить UIFont для кастомного шрифта с указанным именем, размером и весом
//            return UIFont(name: name, size: size)
//        case .system(let size, let design):
//            // Для системных шрифтов, возвращаем стандартный системный шрифт
//            return UIFont.systemFont(ofSize: size)
//        default:
//            return nil
//        }
//    }
//}
