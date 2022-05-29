//
//  ExpenseCategoryView.swift
//  MyCar
//
//  Created by Denis Kuzmin on 17.05.2022.
//

import SwiftUI

struct ExpenseCategoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private let rows = ["Дата", "Сумма", "Пробег", "Описание"]
    private let maxHeightRows = 45.0
    
    @FocusState private var textFieldsFocused: Bool
    @Binding var homeNeedsToUpdate: Bool
    @ObservedObject var viewModel: ExpenseViewModel
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(rows[0])
                    DatePicker("",
                               selection: $viewModel.date,
                               in: ...Date(),
                               displayedComponents: [.date])
                }.frame(maxHeight: maxHeightRows)
                HStack {
                    Text(rows[1])
                    TextField("", value: $viewModel.summ, formatter: numberFormatter)
                        .focused($textFieldsFocused)
                        .keyboardType(.decimalPad)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                }.frame(maxHeight: maxHeightRows)
                HStack {
                    Text(rows[2])
                    Spacer()
                    TextField("", value: $viewModel.mileage, formatter: numberFormatter)
                        .focused($textFieldsFocused)
                        .keyboardType(.decimalPad)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                }.frame(maxHeight: maxHeightRows)
                HStack {
                    Text(rows[3])
                    TextEditor(text: $viewModel.description)
                        .disableAutocorrection(true)
                        .keyboardType(.alphabet)
                        .multilineTextAlignment(.center)
                }.frame(maxHeight: maxHeightRows)
                
                Button(action: {
                    textFieldsFocused = false
                    viewModel.addExpense()
                }) {
                    Text("Добавить")
                        .tint(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.button)
                        }
                }
                
                
                Text("Предыдущие расходы")
                    .padding()
                
                List(viewModel.previousExpenses, id: \.date) { item in
                    HStack {
                        Text(item.dateString)
                        Spacer()
                        Text(item.summString)
                    }
                }
                .listStyle(.plain)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.title)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { mode.wrappedValue.dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.backward").font(.body.bold())
                        Text("Мой авто")
                    }
                }
            }
        }
        .onDisappear(perform: { homeNeedsToUpdate = true})
        .alert(isPresented: $viewModel.alert) {
            Alert(
                title: Text("Неправильное значение пробега"),
                message: Text("Значение пробега не согласуется с ранее введенными значениями"),
                dismissButton: .default(
                    Text("Закрыть")
                )
            )
        }
    }
}
