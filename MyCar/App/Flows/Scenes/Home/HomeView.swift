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
                        let buttonHeight = min(geometry.size.width, geometry.size.height - geometry.size.width) * 0.25
                        let buttonWidth = geometry.size.width * 0.25
                        
                        VStack(alignment: .center) {
                            Text(viewModel.carName).font(Font.title)
                            Text(viewModel.carNumber)
                            Spacer()
                            PieChartView(values: viewModel.segments, colors: viewModel.colors, names: viewModel.names)
                                .scaleEffect(0.75)
                            Spacer()
                            HStack(alignment: .center, spacing: 20.0) {
                                Text(viewModel.total).font(Font.title2)
                                if viewModel.shouldShowAverage {
                                    Text(viewModel.expenciesPerDistanceUnit)
                                        .foregroundColor(viewModel.colors[2])
                                }
                            }
                            Spacer()
                            VStack(spacing: geometry.size.width / 16) {
                                ForEach(0...1, id: \.self) { row in
                                    HStack(spacing: geometry.size.width / 16) {
                                        ForEach(0...2, id: \.self) { col in
                                            let index = row * 3 + col
                                            let tag = String(index)
                                            NavigationLink(destination:
                                                            LazyView(
                                                                ExpenseCategoryView(homeNeedsToUpdate: $viewModel.homeNeedsToUpdate, viewModel: ExpenseViewModel(type: viewModel.expensesTypes[index]))),
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
                } else {
                    Text("Не выбран автомобиль в гараже")
                }
            }
            .navigationTitle("Мой автомобиль")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: GarageView()) {
                        Text("Гараж")
                    }
                }
            }
        }
        .onAppear(perform: { viewModel.calculateExpenses() })
    }
}


