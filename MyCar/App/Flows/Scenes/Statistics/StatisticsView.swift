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
        GeometryReader { geometry in
            VStack {
                LineView(data: viewModel.data,
                         title: "Мои расходы",
                         legend: "руб.",
                         frameRect: geometry.frame(in: .local))
                
                Picker("Period", selection: $viewModel.periodChoice) {
                    ForEach(0 ..< settings.count, id: \.self) { index in
                        Text(settings[index])
                            .tag(index)
                    }

                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
            }
            .onAppear {
                viewModel.getExpenses(period: viewModel.period)
            }
        }
    }
}

//struct StatisticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//    }
//}
