//
//  StatisticsView.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel = StatisticsViewModel()
    
    var settings = ["30 дней", "90 дней", "6 мес", "1 год"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    LineView(data: viewModel.data,
                             legend: "₽",
                             frameRect: geometry.frame(in: .local),
                             currentIndex: $viewModel.currentIndex)
                    
                    Picker("Period", selection: $viewModel.periodChoice) {
                        ForEach(0 ..< settings.count, id: \.self) { index in
                            Text(settings[index])
                                .tag(index)
                        }

                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 20)
                    
                    if let currentModel = viewModel.currentModel {
                        VStack {
                            Divider()
                            Text("\(currentModel.period.start.description) - \(currentModel.period.end.description)")
                            Divider()
                            ForEach(currentModel.models, id: \.expensesType) { expenses in
                                HStack {
                                    Text("\(expenses.expensesType.rawValue)")
                                    Spacer()
                                    Text("\(expenses.price, specifier: "%.2f")")
                                }
                                .padding(.horizontal, 70)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                .onAppear {
                    viewModel.groupByPeriod(period: viewModel.period)
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle("Мои расходы")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct StatisticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//    }
//}
