//
//  Items.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 08.05.2023.
//

import Foundation

struct Item {
    
    let title: String
    let image: String
    
}
    
struct Incomes {
    
    var incomes: [Item] = [Item(title: "Зарплатня", image: "salary"),
                           Item(title: "Подарунки", image: "giftbox"),
                           Item(title: "Депозит", image: "deposit"),
                           Item(title: "Крипто", image: "bitcoin"),
                           Item(title: "Інший дохід", image: "otherincomes")]
}

struct Expenses {
    
    var expenses: [Item] = [Item(title: "Продукти", image: "grocery"),
                            Item(title: "Кафе та ресторани", image: "burger"),
                            Item(title: "Одяг", image: "clothing"),
                            Item(title: "Подорожі", image: "landing"),
                            Item(title: "Освіта", image: "education"),
                            Item(title: "Авто", image: "car"),
                            Item(title: "Проїзд", image: "bus"),
                            Item(title: "Платежі та комісії", image: "payments"),
                            Item(title: "Спорт", image: "sport"),
                            Item(title: "Догляд за собою", image: "selfcare")]
}
