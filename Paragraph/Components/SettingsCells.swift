//
//  SettingsCells.swift
//  Paragraph
//
//  Created by Александр Коробицын on 14.03.2025.
//

import Foundation
import SwiftUI

//MARK: - FontStyle

struct fontStyleCell: View {
    
    @State private var selectedPage = 2
    let pages = ["Times new roman", "Helvetica", "Arial", "Verdana"]
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                
                TabView(selection: $selectedPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Text(pages[index])
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


//MARK: - FontSize

struct FontSizeCell: View {
    
    @AppStorage("fontSizeValue") private var size: Double = 20
    @AppStorage("fontSizeIndex") private var index: Int = 2
    private let sizeList = [15, 20, 25, 30, 35, 40, 45]
    
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
                    
                    TabView(selection: $index) {
                        ForEach(0..<sizeList.count, id: \.self) { index in
                            Text("Aa")
                                .font(.system(size: CGFloat(size),
                                              weight: .light))
                                .foregroundStyle(.black)
                        }
                    }
                    .disabled(true)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    Spacer()
                    
                    Selector(mode: .settingsLessAndMore, action: { i in
                        
                        if i == 0 {
                            if index > 0 {
                                index -= 1
                            } else {
                                index = 0
                            }
                            size = Double(sizeList[index])
                        } else {
                            if index < sizeList.count - 1 {
                                index += 1
                            } else {
                                index = sizeList.count - 1
                            }
                            size = Double(sizeList[index])
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



//MARK: - LineSpacing

struct LineSpacingCell: View {
    
    @State private var spacingIndex = 0
    let spacing = [1, 3, 5, 7, 9, 11, 13]
    
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
                    
                    TabView(selection: $spacingIndex) {
                        ForEach(0..<spacing.count, id: \.self) { index in
                            Text("Aa\nAa\n")
                                .lineSpacing(CGFloat(spacing[spacingIndex]))
                                .foregroundStyle(.black)
                        }
                    }
                    .disabled(true)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    Spacer()
                    
                    Selector(mode: .settingsLessAndMore, action: { i in
                        if i == 0 {
                            if spacingIndex > 0 {
                                spacingIndex -= 1
                            } else {
                                spacingIndex = 0
                            }
                        } else {
                            if spacingIndex < spacing.count - 1 {
                                spacingIndex += 1
                            } else {
                                spacingIndex = spacing.count - 1
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

//MARK: - TransferOfWords


struct TransferOfWordsCell: View {
    
    @State private var isOn: Bool = true
    
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
                    Spacer()
                    Text("Aa -")
                        .foregroundStyle(.black)
                    Spacer()
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: .customGold))
                        .padding(.trailing, 35)
                        .frame(width: 100)
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

//MARK: - Justification

struct JustificationCell: View {
    
    @State private var isOn: Bool = true
    
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
                    Spacer()
                    Text("|Aa     Aa|")
                        .foregroundStyle(.black)
                    Spacer()
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: .customGold))
                        .padding(.trailing, 35)
                        .frame(width: 100)
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
    }
}

//MARK: - LeafingMode


struct LeafingModeCell: View {
    
    @State private var leafingIndex: Int = 0
    
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
                    Selector(mode: .settingsLeafing(leafingIndex), action: { i in
                        leafingIndex = i
                    })
                }.frame(height: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .buttonStyle(.plain)
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
        LeafingModeCell()
    }
    .frame(height: 100)
}
