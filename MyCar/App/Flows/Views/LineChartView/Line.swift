//
//  Line.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct Line: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var touchLocation: CGPoint
    @Binding var showIndicator: Bool
    @Binding var minDataValue: Double?
    @Binding var maxDataValue: Double?
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    
    var gradient: GradientColor = GradientColor(start: Colors.GradientPurple,
                                                end: Colors.GradientNeonBlue)
    let padding: CGFloat = 30
    var stepWidth: CGFloat {
        if data.points.count < 2 { return 0 }
        return frame.size.width / CGFloat(data.points.count-1)
    }
    
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        let points = data.onlyPoints()
        if minDataValue != nil && maxDataValue != nil {
            min = minDataValue!
            max = maxDataValue!
        } else if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        } else {
            return 0
        }
        if let min = min, let max = max, min != max {
            if (min <= 0) {
                return (frame.size.height-padding) / CGFloat(max - min)
            } else {
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var path: Path {
        let points = data.onlyPoints()
        return Path.quadCurvedPathWithPoints(points: points,
                                             step: CGPoint(x: stepWidth, y: stepHeight),
                                             globalOffset: minDataValue)
    }
    
    public var body: some View {
        ZStack {
            path
                .trim(from: 0, to: showFull ? 1:0)
                .stroke(LinearGradient(gradient: gradient.getGradient(),
                                       startPoint: .leading,
                                       endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .onAppear {
                    withAnimation(.linear(duration: 1.2)) {
                        showFull = true
                    }
                }
                .onDisappear {
                    showFull = false
                }
                .onChange(of: data.onlyPoints()) { _ in
                    showFull = false
                    withAnimation(.linear(duration: 1.2)) {
                        showFull = true
                    }
                }
            if(showIndicator) {
                IndicatorPoint()
                    .position(getClosestPointOnPath(touchLocation: touchLocation))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
    
    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        path.point(to: touchLocation.x)
    }
    
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Line(data: ChartData(points: [12, -230, 10, 54]),
                 frame: .constant(geometry.frame(in: .local)),
                 touchLocation: .constant(CGPoint(x: 100, y: 12)),
                 showIndicator: .constant(true),
                 minDataValue: .constant(nil),
                 maxDataValue: .constant(nil))
        }.frame(width: 320, height: 160)
    }
}
