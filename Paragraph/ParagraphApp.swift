//
//  ParagraphApp.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

@main
struct ParagraphApp: App {
    
    @StateObject private var textTypographyHelper = TextTypographyHelper()
    @StateObject private var textConstructHelper = TextConstructHelper()
    @StateObject private var colorThemeHelper = ColorThemeHelper()
    @StateObject private var contentTestingHelper = ContentTestingHelper()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(textTypographyHelper)
                .environmentObject(textConstructHelper)
                .environmentObject(colorThemeHelper)
                .environmentObject(contentTestingHelper)
        }
    }
}
