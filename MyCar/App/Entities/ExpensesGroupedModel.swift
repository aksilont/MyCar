//
//  ExpensesGroupedModel.swift
//  MyCar
//
//  Created by Aksilont on 28.05.2022.
//

import Foundation

struct ExpensesGroupedModel {
    let period: (start: Date, end: Date)
    let models: [ExpensesModel]
    
    func groupByType() -> ExpensesGroupedModel {
        let grouped = Dictionary(grouping: models, by: { $0.expensesType })
        let wraped = grouped
            .compactMap { (key: ExpensesType, models: [ExpensesModel]) -> ExpensesModel in
                let sum = models.compactMap { $0.price }.reduce(0.0, +)
                let distance = models.compactMap { $0.distance }.reduce(0.0, +)
                let newModel = ExpensesModel(expensesType: key,
                                           date: period.start,
                                           price: sum,
                                           distance: distance,
                                           comment: "\(period.start)")
                return newModel
            }
        let newGroup = ExpensesGroupedModel(period: period, models: wraped)
        return newGroup
    }
}
