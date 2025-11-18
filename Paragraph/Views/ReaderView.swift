//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @Binding var selfPresented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textTypographyHelper: TextTypographyHelper
    @EnvironmentObject private var textConstructHelper: TextConstructHelper
    @EnvironmentObject private var colorThemeHelper: ColorThemeHelper
    @EnvironmentObject private var contentTestingHelper: ContentTestingHelper
    
    @State private var textLoadingContent: TextLoadingContent?
    
    var body: some View {
        
        let font = textTypographyHelper.getFont()
        let uIFont = textTypographyHelper.getUIFont()
        
        let interval = textTypographyHelper.getInterval()
        let padding = textTypographyHelper.getPadding()
        
        let typographyMetrics = TypographyMetrics(font: font, uIFont: uIFont, interval: interval, padding: padding)
        
        let backgroundColor = colorThemeHelper.theme().background
        let textColor = colorThemeHelper.theme().text
        
        if selfPresented {
            GeometryReader { geometry in
                
                Color(.clear)
                
                    .onAppear() {
                        textLoadingContent = textConstructHelper.contentUpdate(
                            book: contentTestingHelper.content,
                            metrics: typographyMetrics,
                            geometry: geometry)
                    }
                
                    .onChange(of: font) {
                        textLoadingContent = textConstructHelper.contentUpdate(
                            book: contentTestingHelper.content,
                            metrics: typographyMetrics,
                            geometry: geometry)
                    }
                
                    .onChange(of: [interval, padding]) {
                        textLoadingContent = textConstructHelper.contentUpdate(
                            book: contentTestingHelper.content,
                            metrics: typographyMetrics,
                            geometry: geometry)
                    }
                    .onChange(of: contentTestingHelper.progressPart) {
                        textLoadingContent = textConstructHelper.contentUpdate(
                            book: contentTestingHelper.content,
                            metrics: typographyMetrics,
                            geometry: geometry)
                    }
                
                
                ZStack(alignment: .top) {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    
                    //MARK: - PageView
                    
                    if textConstructHelper.isContentReady {
                        VStack(spacing: 0) {
                            TopMarginLine(width: geometry.size.width - padding * 2)
                            TextView(backColor: backgroundColor,
                                     textColor: textColor,
                                     font: font,
                                     interval: interval,
                                     padding: padding,
                                     textLoadingContent: textLoadingContent!,
                                     updateContent: { swipeState in
                                switch swipeState {
                                    
                                case .previous:
                                    contentTestingHelper.progressPart -= 1
                                case .next:
                                    contentTestingHelper.progressPart += 1
                                }
                            })
                            .ignoresSafeArea()
                        }
                        
                        
                        
                        VStack(spacing: 0) {
                            VStack {
                                Spacer()
                                Selector(mode: .readerControls) { i in
                                    if i == 0 {
                                        settingsPresented.toggle()
                                    } else {
                                        selfPresented.toggle()
                                        settingsPresented = false
                                    }
                                }
                            }
                            
                            SettingsView(presented: $settingsPresented)
                        }
                    }
                }
            }
        }
    }
    
    
    
}


#Preview {
    ReaderView(selfPresented: .constant(true))
        .environmentObject(TextTypographyHelper())
        .environmentObject(ColorThemeHelper())
        .environmentObject(TextConstructHelper())
        .environmentObject(ContentTestingHelper())
}
