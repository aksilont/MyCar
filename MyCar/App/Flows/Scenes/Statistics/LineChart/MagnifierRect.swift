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
        ZStack{
            Text("\(currentNumber, specifier: valueSpecifier)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y: -130)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            if (colorScheme == .dark ) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: colorScheme == .dark ? 2 : 0)
                    .frame(width: 60, height: 300)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 60, height: 300)
                    .foregroundColor(Color.white)
                    .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6 )
                    .blendMode(.multiply)
            }
        }
//        .offset(x: 0, y: -15)
    }
}
