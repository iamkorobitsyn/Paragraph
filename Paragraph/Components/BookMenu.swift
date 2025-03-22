//
//  Test.swift
//  Paragraph
//
//  Created by Александр Коробицын on 22.03.2025.
//

import SwiftUI

struct BookMenu: View {
    // Массив вариантов для Menu
    let options = ["Option 1", "Option 2", "Option 3", "Option 4"]
    
    // Состояние для выбранного значения
    @State private var selectedOption = "Option 1"
    
    var body: some View {
        Menu {
            // Добавляем элементы в меню
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selectedOption = option  // Обновляем выбранное значение
                }
            }
        } label: {
            Image(systemName: "minus.circle.fill")  // Иконка кнопки
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
        .background(Color.clear) // Убираем фон, делаем его прозрачным
        .cornerRadius(10) // При необходимости добавьте скругление
        .preferredColorScheme(.dark) // Принудительное использование темной темы
    }
}
