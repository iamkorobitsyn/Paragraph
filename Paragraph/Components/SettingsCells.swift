//
//  SettingsCells.swift
//  Paragraph
//
//  Created by Александр Коробицын on 14.03.2025.
//

import Foundation
import SwiftUI


struct fontStyleCell: View {
    
    @State private var selectedPage = 2
    let pages = ["Times new roman", "Helvetica", "Arial", "Verdana"]
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                
                TabView(selection: $selectedPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Text(pages[index])
                            .font(.system(size: 20, weight: .light))
                            .foregroundStyle(.black)
                    }
                }
                .disabled(true)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                Spacer()
                
                Selector(mode: .settingsBackAndForward, action: { i in
                    if i == 0 {
                        if selectedPage > 0 {
                            selectedPage -= 1
                        } else {
                            selectedPage = 0
                        }
                    } else {
                        if selectedPage < pages.count - 1 {
                            selectedPage += 1
                        } else {
                            selectedPage = pages.count - 1
                        }
                    }
                })
                    .padding(.trailing, 20)
            }.frame(height: 100)
            
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
            
    }
}

struct fontScaleCell: View {
    
    @State private var scaleIndex = 3
    let scale = [16, 18, 20, 20, 22, 24, 26]
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack() {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white).opacity(0.3)
                    .cornerRadius(0.5)
                    .padding(.top, -4.5)
                    .padding(.trailing, 20)
                HStack() {
                    
                    TabView(selection: $scaleIndex) {
                        ForEach(0..<scale.count, id: \.self) { index in
                            Text("Aa")
                                .font(.system(size: CGFloat(scale[scaleIndex]),
                                              weight: .light))
                                .foregroundStyle(.black)
                        }
                    }
                    .disabled(true)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    Spacer()
                    
                    Selector(mode: .settingsLessAndMore, action: { i in
                        if i == 0 {
                            if scaleIndex > 0 {
                                scaleIndex -= 1
                            } else {
                                scaleIndex = 0
                            }
                        } else {
                            if scaleIndex < scale.count - 1 {
                                scaleIndex += 1
                            } else {
                                scaleIndex = scale.count - 1
                            }
                        }
                    })
                        .padding(.trailing, 20)
                }.frame(height: 100)
            }
            
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

struct testSwitchCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Toggle("Aa -", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .customGold))
                .font(.system(size: 20, weight: .light))
                .padding(.trailing, 20)
        }.frame(height: 100)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

struct testCell: View {
    
    @State private var isOn: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Selector(mode: .settingsLeafing(0), action: { i in })
        }.frame(height: 100)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
        
}

#Preview {
    ZStack {
        Color(.gray)
        fontScaleCell()
    }
    .frame(height: 100)
}
