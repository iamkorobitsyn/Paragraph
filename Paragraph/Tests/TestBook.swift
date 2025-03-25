//
//  TestBook.swift
//  Paragraph
//
//  Created by Александр Коробицын on 18.03.2025.
//

import Foundation

let testBook = Book(title: "Цирк семьи Пайло",
                    author: "Уилл Эллиотт",
                    coverImage: "",
                    status: .closed,
                    progress: 0.45,
                    text: [
                        TextBlock(text: ["Уилл ", "Эллиотт "],
                                  mode: .bookAuthor),
                        TextBlock(text: ["Цирк ", "семьи ", "Пайло "],
                                  mode: .bookTitle),
                        TextBlock(text: ["Что ", "может ", "быть ", "страшнее ", "клоуна ", "за ", "пределами цирка? ", "Только ", "сам ",  "цирк, ", "в ", "котором ", "клоуны-убийцы ", "воюют ", "с ", "акробатами, ", "а ", "хозяева ", "ставят ", "эксперименты ", "на ", "своих ", "артистах. ", "И ", "только ", "такой ", "мир, ", "полный ", "кошмаров ", "и ", "гротеска, ", "может ", "заставить ", "обычного ", "недотепу-консьержа ", "в ", "буквальном ", "смысле ", "бороться ", "с ", "самим ", "собой ", "– ", "воевать ", "со ", "своим ", "клоунским ", "альтер-эго ", "не ", "на ", "жизнь, ", "а ", "на ", "смерть. ", "Автор ", "романа ", "– ", "Уилл ", "Эллиотт ", "– ", "не ", "понаслышке ", "знает, ", "что ", "такое ", "раздвоение ", "личности, ", "хотя ", "и ", "не ", "считает ", "роман ", "автобиографическим. ", "Тем ", "не ", "менее ", "щупальца ", "шизофрении ", "так ", "тихо, ", "но ", "властно ", "проникают ", "в ", "сознание, ", "что ", "читателю ", "следует ", "быть ", "уверенным ", "в ", "собственном ", "душевном ", "равновесии, ", "прежде ", "чем ", "приниматься ", "за ", "книгу. "],
                                  mode: .annotation),
                        TextBlock(text: ["Что ", "сразу ", "насторожило ", "Джейми ", "– ", "так ", "это ", "взгляд ", "клоуна, ", "изумленный ", "блеск, ", "будто ", "он ", "впервые ", "очутился ", "в ", "этом ", "мире, ", "словно ", "машина ", "Джейми ", "– ", "первое, ", "что ", "он ", "увидел. ", "Казалось, ", "существо ", "только-только ", "вылупилось ", "из ", "огромного ", "яйца, ", "доковыляло ", "до ", "дороги ", "и ", "застыло ", "там, ", "как ", "манекен ", "в ", "витрине ", "магазина. ", "Цветастая ", "рубаха, ", "заправленная ", "в ", "штаны, ", "едва ", "удерживала ", "обвисший ", "живот, ", "руки ", "плотно ", "прижаты ", "к ", "бокам, ", "а ", "ладони, ", "обтянутые ", "белыми ", "перчатками, ", "сжаты ", "в ", "кулаки. ", "Под ", "мышками ", "расплывались ", "пятна ", "от ", "пота. ", "Клоун ", "таращился ", "на ", "него ", "через ", "ветровое ", "стекло ", "нелепыми ", "удивленными ", "глазами, ", "потом ", "интерес ", "пропал, ", "и ", "он ", "отвернулся ", "от ", "машины, ", "едва ", "не ", "задавившей ", "его ", "насмерть. "],
                                  mode: .paragraph),
                        TextBlock(text: ["Часы ", "на ", "приборной ", "панели ", "отсчитали ", "десятую ", "секунду ", "с ", "того ", "момента, ", "как ", "Джейми ", "вдарил ", "по ", "тормозам. ", "Он ", "чувствовал ", "запах ", "жженой ", "резины. ", "За ", "все ", "время, ", "что ", "он ", "провел ", "за ", "рулем, ", "мир ", "лишился ", "двух ", "кошек, ", "одного ", "фазана, ", "и ", "вот ", "теперь ", "к ", "этому ", "списку ", "едва ", "не ", "добавился ", "совершенно ", "одуревший ", "человек. ", "В ", "голове ", "Джейми ", "пронеслись ", "все ", "те ", "напасти, ", "что ", "могли ", "бы ", "свалиться ", "на ", "него, ", "не ", "затормози ", "он ", "вовремя: ", "судебные ", "процессы, ", "обвинения, ", "бессонные ", "ночи ", "и ", "чувство ", "вины ", "до ", "конца ", "жизни. ", "На ", "него ", "накатил ", "приступ ", "гнева, ", "как ", "это ", "бывает ", "у ", "водителей, ", "– ", "он ", "опустил ", "стекло ", "и ", "заорал: "],
                                  mode: .paragraph)
                        
                    ],
                    progressBlock: 2,
                    progressWord: 0)
