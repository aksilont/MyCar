//
//  ExpenseType.swift
//  MyCar
//
//  Created by Denis Kuzmin on 18.05.2022.
//

import Foundation

enum ExpenseType: String, CaseIterable {
    case parking = "Парковка"
    case wash = "Мойка"
    case fix = "Ремонт"
    case fuel = "Топливо"
    case finance = "Финансы"
    case other = "Прочее"
}
