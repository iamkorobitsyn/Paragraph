//
//  Buttons.swift
//  Paragraph
//
//  Created by Александр Коробицын on 11.05.2024.
//

import SwiftUI

struct ProfileButton: View {
    
    let side: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: side * 2, height: side)
                
                .clipShape(RoundedRectangle(cornerRadius: side / 2))
            
                .overlay(RoundedRectangle(cornerRadius: side / 2)
                    .stroke(Color.blue, lineWidth: 2))
            
            Button(action: {}) {
                        Image("Imagee")
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: side, height: side)
                            .cornerRadius(side / 2)
                            .padding(.trailing, side)
                    }
            
            Circle()
                .frame(width: side / 6, height: side / 6)
                .padding(.leading, side)
                .foregroundColor(.green)
                .blur(radius: 2)
                .opacity(0.8)
        }
        
            
    }
}

#Preview {
    ProfileButton(side: 42)
}
