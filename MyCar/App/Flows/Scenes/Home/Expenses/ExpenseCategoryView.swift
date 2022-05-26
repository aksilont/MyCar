//
//  ExpenseCategoryView.swift
//  MyCar
//
//  Created by Denis Kuzmin on 17.05.2022.
//

import SwiftUI

struct ExpenseCategoryView: View {
    
    private let rows = ["Дата", "Сумма", "Пробег", "Описание"]
    
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
            NavigationView {
                List {
                    HStack {
                        Text(rows[0])
                        DatePicker("",
                                   selection: $viewModel.date,
                                   in: ...Date(),
                                   displayedComponents: [.date])
                    }
                    HStack {
                        Text(rows[1])
                        TextField("", value: $viewModel.summ, formatter: numberFormatter)
                            .focused($textFieldsFocused)
                            .keyboardType(.decimalPad)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.center)
                    }
                    HStack {
                        Text(rows[2])
                        Spacer()
                        TextField("", value: $viewModel.mileage, formatter: numberFormatter)
                            .focused($textFieldsFocused)
                            .keyboardType(.decimalPad)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.center)
                    }
                    HStack {
                        Text(rows[3])
                        TextEditor(text: $viewModel.description)
                            .multilineTextAlignment(.center)
                    }
                    Button(action: {
                        textFieldsFocused = false
                        viewModel.addExpense()
                        
                    }) {
                        Text("Добавить")
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.button)
                            }
                    }
                    Text("Предыдущие расходы")
                        .padding()
                    ForEach(0 ..< viewModel.previousExpenses.count, id: \.self) { index in
                        HStack {
                            Text(viewModel.previousExpenses[index].dateString)
                            Spacer()
                            Text(viewModel.previousExpenses[index].summString)
                        }
                    }
                }
                .navigationBarHidden(true)
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.title)
        }.onDisappear(perform: { homeNeedsToUpdate = true})
    }
}
