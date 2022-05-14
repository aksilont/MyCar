//
//  TextFieldLimitModifier.swift
//  MyCar
//
//  Created by Aksilont on 14.05.2022.
//

import SwiftUI
import Combine

struct TextFieldLimitModifier: ViewModifier {
    @Binding var value: String
    var length: Int
    
    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            content
                .onChange(of: $value.wrappedValue) {
                    value = String($0.prefix(length))
                }
        } else {
            content
                .onReceive(Just(value)) {
                    value = String($0.prefix(length))
                }
        }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifier(value: value, length: length))
    }
}
