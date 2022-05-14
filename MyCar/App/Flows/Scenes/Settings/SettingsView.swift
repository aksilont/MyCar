//
//  SettingsView.swift
//  MyCar
//
//  Created by Aksilont on 12.05.2022.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("PIN код")
                        TextField("", text: $viewModel.pinCode)
                            .limitInputLength(value: $viewModel.pinCode, length: viewModel.lenghtPinCode)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                            .keyboardType(.numberPad)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                    }
                    .padding()
                    .background(Color(red: 28/255, green: 42/255, blue: 90/255))
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.white)
                    
                    Button("Save") {
                        viewModel.savePinCode()
                        UIApplication.shared.endEditing()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("Настройки").foregroundColor(.white).fontWeight(.bold)
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }

    }
}

// второй экран
struct View1_1: View {
    var body: some View {
            Text("Переход на View1_2")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
