//
//  HomeViewView.swift
//
//  Created by Denis Kuzmin on 11.05.2022.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                VStack(alignment: .center) {
                    Text(viewModel.carName)
                        .foregroundColor(Color.white)
                        .font(Font.title)
                    Text(viewModel.carNumber)
                        .foregroundColor(Color.white)
                    PieChartView(values: viewModel.segments, colors: viewModel.colors, names: viewModel.names)
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.75)
                        .background(Color.black)
                    HStack(alignment: .center, spacing: 20.0) {
                        Text("Всего \(viewModel.allExpencies) \(viewModel.currencySign)")
                            .foregroundColor(Color.white)
                            .font(Font.title2)
                        Text("\(viewModel.expenciesPerDistanceUnit) \(viewModel.currencySign)/\(viewModel.distanceUnitSign)")
                            .foregroundColor(viewModel.colors[2])
                    }
                    VStack(spacing: geometry.size.width / 16) {
                        ForEach(0...1, id: \.self) { row in
                            HStack(spacing: geometry.size.width / 16) {
                                ForEach(0...2, id: \.self) { col in
                                    Button(action: {}) {
                                        Text(viewModel.names[row * 3 + col])
                                            .foregroundColor(Color.white)
                                            .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
                                    }
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(viewModel.colors[row * 3 + col])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}


