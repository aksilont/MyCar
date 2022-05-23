//
//  Color+Extension.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI

extension Color {
    static let park = Color(CGColor(red: 243/255, green: 172/255, blue: 0, alpha: 1))
    static let wash = Color(CGColor(red: 69/255, green: 150/255, blue: 190/255, alpha: 1))
    static let repair = Color(CGColor(red: 243/255, green: 0/255, blue: 0/255, alpha: 1))
    static let fuel = Color(CGColor(red: 92/255, green: 157/255, blue: 0/255, alpha: 1))
    static let finance = Color(CGColor(red: 118/255, green: 7/255, blue: 136/255, alpha: 1))
    static let other = Color(CGColor(red: 71/255, green: 69/255, blue: 190/255, alpha: 1))
    static let button = Color(cgColor: CGColor(red: 0.2172074616, green: 0.6069719195, blue: 0.6331881881, alpha: 1))
    
    static func expenseColor(_ expense: ExpensesType) -> Color {
        switch expense {
        case .parking: return .park
        case .wash: return .wash
        case .fix: return .repair
        case .fuel: return .fuel
        case .finance: return .finance
        case .other: return .other
        }
    }
}
