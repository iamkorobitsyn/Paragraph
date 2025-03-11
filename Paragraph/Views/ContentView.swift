//
//  ContentView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 08.05.2024.
//

import SwiftUI

struct ContentView: View {

    @State private var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    HStack {
                        ToolBar(sizeWidth: device == .pad ? 500 : 350,
                                sizeHeight: device == .pad ? 250 : 200,
                                paddingEdge: .leading, paddingPoint: 70)
                        Spacer()
                    }
                    
                }.ignoresSafeArea()
            } else {
                ZStack {
                    Image("mainTexture")
                        .resizable()
                    VStack {
                        ToolBar(sizeWidth: device == .pad ? 500 : 350,
                                sizeHeight: device == .pad ? 250 : 200,
                                paddingEdge: .top, paddingPoint: 150)
                        Spacer()
                    }
                }.ignoresSafeArea()
            }
        }
    }
}



#Preview {
    return ContentView()
}
