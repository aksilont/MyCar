//
//  PieChartRows.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI

struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count, id: \.self) { index in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[index])
                        .frame(width: 20, height: 20)
                    Text(self.names[index])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[index])
                        Text(self.percents[index])
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}
