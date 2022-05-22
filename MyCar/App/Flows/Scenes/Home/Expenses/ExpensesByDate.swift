//
//  ExpensesByDate.swift
//  MyCar
//
//  Created by Denis Kuzmin on 20.05.2022.
//

import Foundation

struct ExpensesByDate {
    let date: Date
    var summ: Double
    var dateString: String  { dateFormatter.string(from: date) }
    var summString: String { String(format: "%.2f", summ) }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
