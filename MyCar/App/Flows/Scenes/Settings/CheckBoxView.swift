//
//  CheckBoxView.swift
//  MyCar
//
//  Created by Aksilont on 15.05.2022.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    var action: (() -> ())? = nil
    
    var body: some View {    
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? .green : .white)
            .onTapGesture {
                withAnimation {
                    checked.toggle()
                    action?()
                }
            }
    }
}
