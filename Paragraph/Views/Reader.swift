//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import Foundation
import SwiftUI

struct ReaderView: View {
    
    @Binding var readerPresented: Bool
    
    @State private var fontSize: CGFloat = 18
    @State private var content: String = "Начался и закончился шестичасовой наплыв гостей. Через двери кавалькадой проходили налившиеся пивом сливки общества Брисбена: от совладельцев юридических фирм до телеведущих, заправил Австралийской футбольной лиги, вышедших в тираж звезд крикета, членов парламента штата – и многие другие персонажи, но только не молодые женщины. Воцарилась тишина, единственными звуками, проникавшими сквозь гранитные стены, были приглушенный шум уличного движения, затихающее биение близившегося к концу рабочего дня и пробуждавшийся пульс ночной жизни большого города. Вестибюль опустел, покой иногда нарушали члены клуба, выходившие из него более пьяными и довольными, чем когда пришли. Как только последний из них, пошатываясь, вышел на улицу, Джейми погрузился в научно-фантастический роман, время от времени озираясь через плечо, как бы его за этим занятием не застукало начальство или кто-то из шишек Брисбена. Это, в противовес вечерней суматохе, было не таким уж плохим способом зарабатывать восемнадцать долларов в час."
    
    var body: some View {
        ZStack {
            VStack {
                // Слайдер для изменения размера шрифта
                Slider(value: $fontSize, in: 12...36, step: 1)
                    .padding()
                    .onChange(of: fontSize) {
                        print(fontSize)
                    }

                // ScrollView для перелистывания текста
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Заголовок")
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        // TextEditor для редактирования текста
                        TextEditor(text: $content)
                            .font(.system(size: fontSize))
                            .padding()
                            .frame(height: 400)
                            .border(Color.gray, width: 1)
                            .cornerRadius(8)
                            .foregroundColor(.primary)
                    }
                }
            }
            
            // Кнопка для закрытия
            Button(action: { readerPresented.toggle() }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .position(x: 30, y: 30)  // Расположение кнопки
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView(readerPresented: .constant(true))
    }
}
