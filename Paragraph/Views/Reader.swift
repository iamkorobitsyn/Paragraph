//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    let device: UIUserInterfaceIdiom
    
    @State private var textLines: [TextLine] = []
    private enum Indent {
        case min, mid, max
    }
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var pages = [0, 1]
    @State private var currentPage = 0
    
    
    var body: some View {
        
        let content = Book(title: "Цирк семьи Пайло",
                           author: "Уилл Элиот",
                           coverImage: "",
                           status: .open,
                           progress: 58.5,
                           text: [TextBlock(text: textService.textConvert(text: "Что может быть страшнее клоуна за пределами цирка? Только сам цирк, в котором клоуны-убийцы воюют с акробатами, а хозяева ставят эксперименты на своих артистах. И только такой мир, полный кошмаров и гротеска, может заставить обычного недотепу-консьержа в буквальном смысле бороться с самим собой – воевать со своим клоунским альтер-эго не на жизнь, а на смерть. Автор романа – Уилл Эллиотт – не понаслышке знает, что такое раздвоение личности, хотя и не считает роман автобиографическим. Тем не менее щупальца шизофрении так тихо, но властно проникают в сознание, что читателю следует быть уверенным в собственном душевном равновесии, прежде чем приниматься за книгу."),
                                            mode: .paragraph),
                                  TextBlock(text: textService.textConvert(text: "Что сразу насторожило Джейми – так это взгляд клоуна, изумленный блеск, будто он впервые очутился в этом мире, словно машина Джейми – первое, что он увидел. Казалось, существо только-только вылупилось из огромного яйца, доковыляло до дороги и застыло там, как манекен в витрине магазина. Цветастая рубаха, заправленная в штаны, едва удерживала обвисший живот, руки плотно прижаты к бокам, а ладони, обтянутые белыми перчатками, сжаты в кулаки. Под мышками расплывались пятна от пота. Клоун таращился на него через ветровое стекло нелепыми удивленными глазами, потом интерес пропал, и он отвернулся от машины, едва не задавившей его насмерть."),
                                            mode: .paragraph),
                                  TextBlock(text: textService.textConvert(text: "Часы на приборной панели отсчитали десятую секунду с того момента, как Джейми вдарил по тормозам. Он чувствовал запах жженой резины. За все время, что он провел за рулем, мир лишился двух кошек, одного фазана, и вот теперь к этому списку едва не добавился совершенно одуревший человек. В голове у Джейми пронеслись все те напасти, что могли бы свалиться на него, не затормози он вовремя: судебные процессы, обвинения, бессонные ночи и чувство вины до конца жизни. На него накатил приступ гнева, как это бывает у водителей, – он опустил стекло и заорал:"),
                                            mode: .paragraph)],
                           progressBlock: 0,
                           progressWord: 0)
        
        
        
        let font = textService.getFont()
        let uIFont = textService.getUIFont()
        
        let interval = textService.getInterval()
        let padding = textService.getPadding()
        
        let backgroundColor = colorService.theme().background
        let textColor = colorService.theme().text
  
        if presented {
            GeometryReader { geometry in
                Color(.clear)
  
                    .onAppear() {
                        contentUpdate(content, geometry, uIFont, interval, padding)
                    }
        
                    .onChange(of: font) {
                        contentUpdate(content, geometry, uIFont, interval, padding)
                    }
                
                    .onChange(of: [interval, padding]) {
                        contentUpdate(content, geometry, uIFont, interval, padding)
                    }
                
                

                
                ZStack(alignment: .top) {
                    Color(backgroundColor)
                        .ignoresSafeArea()

                    HStack() {
                        Text("Цирк семьи пайло")
                            .foregroundStyle(Color.gray)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], padding)
                            .padding(.top, 20)
                    }
   
                    VStack() {
                        
                        HStack() {
                            
                            Spacer()
                            Selector(mode: .readerControls) { i in
                                if i == 0 {
                                    settingsPresented.toggle()
                                } else {
                                    presented.toggle()
                                    settingsPresented = false
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        .frame(height: 50)
                        
                        ZStack {
                            
                            TabView(selection: $currentPage) {
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<textLines.count, id: \.self) { index in
                                        TextLineView(font: font,
                                                     fontColor: textColor,
                                                     textLine: textLines[index],
                                                     interval: interval,
                                                     padding: padding,
                                                     endBlock: textLines[index].isEndOfBlock)
                                    }
                                }
                                
                                Rectangle().fill(.clear)
                            }
                            .tabViewStyle(.page)
                            .onChange(of: currentPage) {
                                pages.append(2)
                                pages.removeFirst()
                            }
                            
                            TabView(selection: $currentPage) {
                                LazyVStack(spacing: 0) {
                                    ForEach(0..<textLines.count, id: \.self) { index in
                                        TextLineView(font: font,
                                                     fontColor: textColor,
                                                     textLine: textLines[index],
                                                     interval: interval,
                                                     padding: padding,
                                                     endBlock: textLines[index].isEndOfBlock)
                                    }
                                }
                                
                                Rectangle().fill(.clear)
                            }
                            .tabViewStyle(.page)
                            .onChange(of: currentPage) {
                                pages.append(2)
                                pages.removeFirst()
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                        
//                        GeometryReader { geometry in
//                            ScrollView(.horizontal, showsIndicators: true) {
//                                        HStack(spacing: 0) {
//                                            ForEach(0..<pages.count, id: \.self) { page in
//                                                LazyVStack(spacing: 0) {
//                                                    ForEach(0..<textLines.count, id: \.self) { index in
//                                                        TextLineView(font: font,
//                                                                     fontColor: textColor,
//                                                                     textLine: textLines[index],
//                                                                     interval: interval,
//                                                                     padding: padding,
//                                                                     endBlock: textLines[index].isEndOfBlock)
//                                                    }
//                                                }
//                                                .tag(page)
//                                            }
//                                        }
//                                        .offset(x: -CGFloat(currentPage) * geometry.size.width) // Перемещение страниц
//                                        .animation(.linear, value: currentPage) // Анимация перелистывания
//                                    }
//                            .scrollDisabled(true)
//                                    .gesture(
//                                        DragGesture()
//                                            .onEnded { value in
//                                                let threshold = geometry.size.width / 3
//                                                if value.translation.width < -threshold {
//                                                    currentPage = min(currentPage + 1, pages.count - 1)
//                                                } else if value.translation.width > threshold {
//                                                    currentPage = max(currentPage - 1, 0)
//                                                }
//                                            }
//                                    )
//                                }
                        
                        
                        
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        Text("58 %")
                            .foregroundStyle(Color.gray)
                        .frame(height: 50)
                        .padding(.bottom, 10)
                    }
                    .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    SettingsView(presented: $settingsPresented)
                }
            }
        }
    }

    
    private func contentUpdate(_ content: Book,
                               _ geometry: GeometryProxy,
                               _ uIFont: UIFont,
                               _ interval: CGFloat,
                               _ padding: CGFloat) {

        textLines = []

        let maxWidht = geometry.size.width - padding * 2
        let maxHeight = geometry.size.height - 100
        
        var tempHeight: CGFloat = 0

        textService.updateProgress(content: content)
        
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, maxWidth: maxWidht, uIFont: uIFont)
            if maxHeight < tempHeight + wordsLine.textHight { break }
            textLines.append(wordsLine)
            tempHeight += wordsLine.textHight + interval
        }
    }
}

struct TextLineView: View {
    
    let font: Font
    let fontColor: Color
    let textLine: TextLine
    let interval: CGFloat
    let padding: CGFloat
    let endBlock: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            if textLine.isStartOfBlock && textLine.mode == .paragraph {
                Rectangle().fill(.clear)
                    .frame(width: 20)
            }
            
                ForEach(Array(textLine.text.enumerated()), id: \.offset) { i, word in
                        if !endBlock {
     
                            WordView(i: word.id, text: word.text, font: font, color: fontColor, interval: interval)

                            if i != textLine.text.count - 1 || textLine.text.count == 1 {
                                Spacer(minLength: 0)
                            }
                            
                        } else {
                            WordView(i: word.id, text: word.text, font: font, color: fontColor, interval: interval)
                            
                            
                            if i == textLine.text.count - 1 {
                                Spacer(minLength: 0)
                            }
                        }
                }
            
        }
        
        .padding([.leading, .trailing], padding)
    }
}

struct WordView: View {
    let i: Int
    let text: String
    let font: Font
    let color: Color
    let interval: CGFloat
    
    @State private var isHighlighted: Bool = false
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(isHighlighted ? Color.white : color)
            .background(isHighlighted ? Color.blue : .clear)
            
            .lineLimit(1)
            .padding(.top, interval)
        
            .onTapGesture {
                isHighlighted.toggle()
                print(i)
            }
    }
}


#Preview {
    ReaderView(device: .phone, presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
