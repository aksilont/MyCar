//
//  ExpenseCategoryView.swift
//  MyCar
//
//  Created by Denis Kuzmin on 17.05.2022.
//

import SwiftUI

struct ExpenseCategoryView: View {
    
    var rows = ["Дата", "Сумма", "Пробег", "Описание"]
    @FocusState private var textFieldsFocused: Bool
    
    @ObservedObject var viewModel: ExpenseViewModel
    
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
                        TextField("", value: $viewModel.summ, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .focused($textFieldsFocused)
                    }
                    HStack {
                        Text(rows[2])
                        TextField("", value: $viewModel.mileage, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .focused($textFieldsFocused)
                    }
                    HStack {
                        Text(rows[3])
                        TextField("", text: $viewModel.description)
                            .multilineTextAlignment(.trailing)
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
                            Text(viewModel.previousExpenses[index].summString)
                        }
                    }
                }
                .navigationBarHidden(true)
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.title)
        }
        }
        
}
