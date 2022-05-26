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
                
                Picker("Period", selection: $viewModel.periodChoioce) {
                    ForEach(0 ..< settings.count, id: \.self) { index in
                        Text(self.settings[index])
                            .tag(index)
                    }

                }
                .pickerStyle(SegmentedPickerStyle())
                .offset(y: 70)
                Spacer()
            }
        }
    }
}

//struct StatisticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticsView()
//    }
//}
