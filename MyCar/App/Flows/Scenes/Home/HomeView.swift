//
//  HomeViewView.swift
//
//  Created by Denis Kuzmin on 11.05.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var selection: String? = nil
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isActiveCar {
                    GeometryReader { geometry in
                        let pieChartSize = geometry.size.width * 0.75
                        let buttonHeight = min(geometry.size.width, geometry.size.height - geometry.size.width) * 0.25
                        let buttonWidth = geometry.size.width * 0.25
                        ZStack {
                            Color.black
                            
                            VStack(alignment: .center) {
                                Text(viewModel.carName)
                                    .foregroundColor(Color.white)
                                    .font(Font.title)
                                Text(viewModel.carNumber)
                                    .foregroundColor(Color.white)
                                Spacer()
                                PieChartView(values: viewModel.segments, colors: viewModel.colors, names: viewModel.names)
                                    .frame(width: pieChartSize, height: pieChartSize)
                                    .background(Color.black)
                                Spacer()
                                HStack(alignment: .center, spacing: 20.0) {
                                    Text(viewModel.total)
                                        .foregroundColor(Color.white)
                                        .font(Font.title2)
                                    Text(viewModel.expenciesPerDistanceUnit)
                                        .foregroundColor(viewModel.colors[2])
                                }
                                Spacer()
                                VStack(spacing: geometry.size.width / 16) {
                                    ForEach(0...1, id: \.self) { row in
                                        HStack(spacing: geometry.size.width / 16) {
                                            ForEach(0...2, id: \.self) { col in
                                                let index = row * 3 + col
                                                let tag = String(index)
                                                let destinationViewModel = ExpenseViewModel(type: viewModel.expensesTypes[index])
                                                NavigationLink(destination:
                                                                LazyView(
                                                                    ExpenseCategoryView(homeNeedsToUpdate: $viewModel.homeNeedsToUpdate, viewModel: destinationViewModel)),
                                                               tag: tag,
                                                               selection: $selection) {
                                                    Button(action: { selection = tag }) {
                                                        Text(viewModel.names[index])
                                                            .foregroundColor(Color.white)
                                                            .frame(width: buttonWidth, height: buttonHeight)
                                                            .background {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .fill(viewModel.colors[index])
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("Не выбран автомобиль в гараже")
                    }
                }
            }
            .navigationBarItems(leading: Button(action: { viewModel.didTapGarageButton() }) {
                Text("Гараж")
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Мой автомобиль")
        }
        .onAppear(perform: { viewModel.calculateExpenses() })
        
    }
}


