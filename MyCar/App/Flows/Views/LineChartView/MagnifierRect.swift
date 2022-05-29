//
//  MagnifierRect.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct MagnifierRect: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var currentNumber: Double
    
    var valueSpecifier: String
    
    var body: some View {
        Text("\(currentNumber, specifier: valueSpecifier)")
            .font(.system(size: 18, weight: .bold))
            .offset(x: 0, y: -130)
            .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
    }
}
