//
//  ReaderView.swift
//  Paragraph
//
//  Created by Александр Коробицын on 07.03.2025.
//

import SwiftUI

struct ReaderView: View {
    
    @State private var textLinesOfCurrentPage: [TextLine] = []
    @State private var textLinesOfNextPage: [TextLine] = []
    
    @Binding var presented: Bool
    @State private var settingsPresented: Bool = false
    
    @EnvironmentObject private var textService: TextService
    @EnvironmentObject private var colorService: ColorService
    
    @State private var progressBlock: Int = 0
    @State private var progressWord: Int = 0
    
    @State private var nextPageBlockIndex = 0
    @State private var nextPageWordIndex = 0
    
    
    
    var body: some View {
        
        
        
        let content = Book(title: "Цирк семьи Пайло",
                           author: "Уилл Элиот",
                           coverImage: "",
                           status: .open,
                           progress: 58.5,
                           textBlocks: [TextBlock(text: textService.textConvert(text: "Что может быть страшнее клоуна за пределами цирка? Только сам цирк, в котором клоуны-убийцы воюют с акробатами, а хозяева ставят эксперименты на своих артистах. И только такой мир, полный кошмаров и гротеска, может заставить обычного недотепу-консьержа в буквальном смысле бороться с самим собой – воевать со своим клоунским альтер-эго не на жизнь, а на смерть. Автор романа – Уилл Эллиотт – не понаслышке знает, что такое раздвоение личности, хотя и не считает роман автобиографическим. Тем не менее щупальца шизофрении так тихо, но властно проникают в сознание, что читателю следует быть уверенным в собственном душевном равновесии, прежде чем приниматься за книгу."),
                                            mode: .paragraph),
                                  TextBlock(text: textService.textConvert(text: "Что сразу насторожило Джейми – так это взгляд клоуна, изумленный блеск, будто он впервые очутился в этом мире, словно машина Джейми – первое, что он увидел. Казалось, существо только-только вылупилось из огромного яйца, доковыляло до дороги и застыло там, как манекен в витрине магазина. Цветастая рубаха, заправленная в штаны, едва удерживала обвисший живот, руки плотно прижаты к бокам, а ладони, обтянутые белыми перчатками, сжаты в кулаки. Под мышками расплывались пятна от пота. Клоун таращился на него через ветровое стекло нелепыми удивленными глазами, потом интерес пропал, и он отвернулся от машины, едва не задавившей его насмерть."),
                                            mode: .paragraph),
                                  TextBlock(text: textService.textConvert(text: "Часы на приборной панели отсчитали десятую секунду с того момента, как Джейми вдарил по тормозам. Он чувствовал запах жженой резины. За все время, что он провел за рулем, мир лишился двух кошек, одного фазана, и вот теперь к этому списку едва не добавился совершенно одуревший человек. В голове у Джейми пронеслись все те напасти, что могли бы свалиться на него, не затормози он вовремя: судебные процессы, обвинения, бессонные ночи и чувство вины до конца жизни. На него накатил приступ гнева, как это бывает у водителей, – он опустил стекло и заорал:"),
                                            mode: .paragraph)])
        
        
        
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

                    VStack(spacing: 0) {
                        
                        HStack() {
                            Text("Цирк семьи пайло")
                                .foregroundStyle(Color.gray)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 40)
                                .padding(.bottom, 9)
                            
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
                            .padding([.top, .bottom], 9)
                        }
                        .frame(height: 60)
                      
         
                        ZStack {
                            PageView(font: font,
                                     interval: interval,
                                     padding: padding,
                                     backgroundColor: backgroundColor,
                                     textColor: textColor,
                                     previousPage: textLinesOfNextPage,
                                     currentPage: textLinesOfCurrentPage,
                                     nextPage: textLinesOfNextPage) { withReverse in
                                progressBlock = nextPageBlockIndex
                                progressWord = nextPageWordIndex
                                contentUpdate(content, geometry, uIFont, interval, padding)
                            }
                            
                        }
                       
                        .frame(height: geometry.size.height - 100)
                 
                        
                    
                        Text("58 %")
                            .foregroundStyle(Color.gray)
                            .frame(height: 40)
                            .padding(.top, 10)
                    }
                    
                    
                }
                VStack {
                    Spacer()
                    SettingsView(presented: $settingsPresented)
                }
            }
        }
    }
    
    //MARK: - ContentUpdate

    
    private func contentUpdate(_ content: Book,
                               _ geometry: GeometryProxy,
                               _ uIFont: UIFont,
                               _ interval: CGFloat,
                               _ padding: CGFloat) {
        
        

        textLinesOfCurrentPage = []
        textLinesOfNextPage = []

        let maxWidht = geometry.size.width - padding * 2
        let maxHeight = geometry.size.height - 100
        
        var tempHeight: CGFloat = 0
        
        textService.currentBlockIndex = progressBlock
        textService.currentWordIndex = progressWord
        
        while tempHeight < maxHeight {
            let wordsLine = textService.getLine(content: content, maxWidth: maxWidht, uIFont: uIFont)
            if maxHeight < tempHeight + wordsLine.textHight { break }
            textLinesOfCurrentPage.append(wordsLine)
            tempHeight += wordsLine.textHight + interval
            nextPageBlockIndex = textService.currentBlockIndex
            nextPageWordIndex = textService.currentWordIndex
            if wordsLine.isEndOfContent {break}
        }
        
        tempHeight = 0
        textService.currentBlockIndex = nextPageBlockIndex
        textService.currentWordIndex = nextPageWordIndex
        
        while tempHeight < maxHeight {
            
            let wordsLine = textService.getLine(content: content, maxWidth: maxWidht, uIFont: uIFont)
            if maxHeight < tempHeight + wordsLine.textHight { break }
            textLinesOfNextPage.append(wordsLine)
            tempHeight += wordsLine.textHight + interval
        }
        
    }
}


#Preview {
    ReaderView(presented: .constant(true))
        .environmentObject(TextService())
        .environmentObject(ColorService())
}
