//
//  Legend.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct Legend: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var specifier: String = "%.2f"
    let padding: CGFloat = 3

    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count-1)
    }
    
    var stepHeight: CGFloat {
        let points = self.data.onlyPoints()
        if let min = points.min(), let max = points.max(), min != max {
            if (min < 0) {
                return (frame.size.height-padding) / CGFloat(max - min)
            } else {
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        let points = data.onlyPoints()
        return CGFloat(points.min() ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach((0...4), id: \.self) { height in
                HStack(alignment: .center){
                    Text("\(getYLegendSafe(height: height), specifier: specifier)")
                        .offset(x: 0, y: getYposition(height: height) )
                        .foregroundColor(Colors.LegendText)
                        .font(.caption)
                    line(atHeight: getYLegendSafe(height: height), width: frame.width)
                        .stroke(colorScheme == .dark ? Colors.LegendDarkColor : Colors.LegendColor,
                                style: StrokeStyle(lineWidth: 1.5,
                                                   lineCap: .round,
                                                   dash: [5, height == 0 ? 0 : 10]))
                        .opacity((hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2), value: hideHorizontalLines)
                        .clipped()
                }
               
            }
            
        }
    }
    
    func getYLegendSafe(height:Int) -> CGFloat{
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    func getYposition(height: Int) -> CGFloat {
        let frameHeight = frame.height
        if let legend = getYLegend() {
            return (frameHeight - ((CGFloat(legend[height]) - min) * stepHeight)) - (frameHeight / 2)
        }
        return 0
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x: 5, y: (atHeight - min) * stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight - min) * stepHeight))
        return hLine
    }
    
    func getYLegend() -> [Double]? {
        let points = data.onlyPoints()
        guard let max = points.max(), let min = points.min()
        else { return nil }
        let step = Double(max - min) / 4
        return [min + step * 0, min + step * 1, min + step * 2, min + step * 3, min + step * 4]
    }
}

struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Legend(data: ChartData(points: [20, 142, 2789, 3000]),
                   frame: .constant(geometry.frame(in: .local)),
                   hideHorizontalLines: .constant(false))
        }.frame(width: 320, height: 200)
    }
}
