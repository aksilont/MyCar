//
//  ContentView.swift
//  SwiftUIPieChart
//
//  Created by Denis Kuzmin on 11.05.2022.
//

import SwiftUI

struct PieChartView: View {
    let values: [Double]
    var colors: [Color]
    let names: [String]
    var withText: Bool
    var withRows: Bool
    
    var backgroundColor: Color
    var innerRadiusFraction: CGFloat
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            if withText {
                tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            } else {
                tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), color: self.colors[i]))
            }
            endDeg += degrees
        }
        return tempSlices
    }
    
    init(values: [Double], colors: [Color], names: [String], backgroundColor: Color = .black, innerRadiusFraction: CGFloat = 0, withText: Bool = false, withRows: Bool = false) {
        self.values = values
        self.colors = colors
        self.names = names
        self.backgroundColor = backgroundColor
        self.innerRadiusFraction = innerRadiusFraction
        self.withText = withText
        self.withRows = withRows
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        PieSliceView(pieSliceData: self.slices[i])
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                    
                    if withText {
                        VStack {
                            Text("Total")
                                .font(.title)
                                .foregroundColor(Color.gray)
                            Text(String(values.reduce(0, +)))
                                .font(.title)
                        }
                    }
                }
                if withRows {
                    PieChartRows(colors: self.colors, names: self.names, values: self.values.map { String($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
                }
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}



