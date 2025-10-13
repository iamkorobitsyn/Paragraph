//
//  ParagraphApp.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

@main
struct ParagraphApp: App {
    
    @StateObject private var textService = TextService()
    @StateObject private var colorService = ColorService()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(textService)
                .environmentObject(colorService)
        }
    }
}
