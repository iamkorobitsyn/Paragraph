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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(textService)
        }
    }
}
