//
//  Color+Additions.swift
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
    
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
    
}
