//
//  LineView.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct LineView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var hideHorizontalLines: Bool = false
    
    @ObservedObject var data: ChartData
    var title: String?
    var legend: String?
    var style: ChartStyle
    var darkModeStyle: ChartStyle
    var valueSpecifier: String
    var legendSpecifier: String
    var frameRect: CGRect
    
    init(data: [Double],
         title: String? = nil,
         legend: String? = nil,
         style: ChartStyle = Styles.lineChartStyleOne,
         frameRect: CGRect,
         valueSpecifier: String = "%.1f",
         legendSpecifier: String = "%.2f") {
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.valueSpecifier = valueSpecifier
        self.legendSpecifier = legendSpecifier
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.frameRect = frameRect
    }
    
    var body: some View {
//        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    if (title != nil){
                        Text(title!)
                            .font(.title)
                            .bold().foregroundColor(colorScheme == .dark ? darkModeStyle.textColor : style.textColor)
                    }
                    if (legend != nil){
                        Text(legend!)
                            .font(.callout)
                            .foregroundColor(colorScheme == .dark ? darkModeStyle.legendTextColor : style.legendTextColor)
                    }
                }//.offset(x: 0, y: 20)
                .padding(.bottom, 20)
                
                ZStack {
                    GeometryReader { reader in
                        Rectangle()
                            .foregroundColor(colorScheme == .dark ? darkModeStyle.backgroundColor : style.backgroundColor)
                        if(showLegend){
                            Legend(data: data,
                                   frame: .constant(reader.frame(in: .local)),
                                   hideHorizontalLines: $hideHorizontalLines,
                                   specifier: legendSpecifier)
                            .transition(.opacity)
                            .animation(Animation.easeOut(duration: 1).delay(1), value: showLegend)
                        }
                        Line(data: data,
                             frame: .constant(CGRect(x: 0,
                                                     y: 0,
                                                     width: reader.frame(in: .local).width - 30,
                                                     height: reader.frame(in: .local).height + 25)),
                             touchLocation: $indicatorLocation,
                             showIndicator: $hideHorizontalLines,
                             minDataValue: .constant(nil),
                             maxDataValue: .constant(nil),
                             showBackground: false,
                             gradient: style.gradientColor
                        )
                        .offset(x: 30, y: 0)
                        .onAppear(){
                            showLegend = true
                        }
                        .onDisappear(){
                            showLegend = false
                        }
                    }
//                    .frame(width: geometry.frame(in: .local).size.width, height: 240)
                    .frame(width: frameRect.size.width, height: 240)
                    //.offset(x: 0, y: 40 )
                    MagnifierRect(currentNumber: $currentDataNumber, valueSpecifier: valueSpecifier)
                        .opacity(opacity)
//                        .offset(x: dragLocation.x - geometry.frame(in: .local).size.width / 2, y: 36)
                        .offset(x: dragLocation.x - frameRect.size.width / 2, y: -15)
                }
//                .frame(width: geometry.frame(in: .local).size.width, height: 240)
                .frame(width: frameRect.size.width, height: 240)
                .gesture(DragGesture()
                    .onChanged { value in
                        dragLocation = value.location
                        indicatorLocation = CGPoint(x: max(value.location.x - 30, 0), y: 32)
                        opacity = 1
                        closestPoint = getClosestDataPoint(
                            toPoint: value.location,
//                            width: geometry.frame(in: .local).size.width-30,
                            width: frameRect.size.width - 30,
                            height: 240)
                        hideHorizontalLines = true
                    }
                    .onEnded { _ in
                        opacity = 0
                        hideHorizontalLines = false
                    }
                )
            }
//        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count) {
            currentDataNumber = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index]) * stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Group {
//                LineView(data: [8,23,54,32,12,37,7,23,43],
//                         title: "Full chart",
//                         style: Styles.lineChartStyleOne,
//                         frameRect: geometry.frame(in: .local))
                
                LineView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188],
                         title: "Full chart",
                         style: Styles.lineChartStyleOne,
                         frameRect: geometry.frame(in: .local))
            }
        }
    }
}

