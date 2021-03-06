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
            ScrollView {
                VStack {
                    HStack {
                        CheckBoxView(checked: $viewModel.usePinCode) {
                            UIApplication.shared.endEditing()
                        }
                        Spacer()
                        Text("PIN")
                        textFieldView
                            .opacity(viewModel.usePinCode ? 1 : 0)
                            .frame(maxWidth: viewModel.usePinCode ? .infinity : 0)
                            .animation(.easeInOut, value: viewModel.usePinCode)
                    }
                    .padding()
                    .background(.teal)
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.white)
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.createTestingExpenses()
                        } label: {
                            Text("Расходы для теста").font(.title3).foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(.teal)
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(.white)
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.deleteAllExpenses()
                        } label: {
                            Text("Удалить все расходы").font(.title3).foregroundColor(.red)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(.teal)
                    .cornerRadius(10)
                    .padding()
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Настройки").fontWeight(.bold)
                }
            }
        }
    }
    
    var textFieldView: some View {
        HStack {
            TextField("", text: $viewModel.pinCode)
                .limitInputLength(value: $viewModel.pinCode, length: viewModel.lenghtPinCode)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding(.horizontal, 5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
            
            Image(systemName: "lock")
                .foregroundColor(viewModel.correctPinCode ? .green : .red)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
