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
            ZStack {
                Color.black.ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Text("Задать PIN код")
                            TextField("", text: $viewModel.pinCode)
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
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("Настройки")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
