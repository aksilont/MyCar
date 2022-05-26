//
//  IndicatorPoint.swift
//  MyCar
//
//  Created by Aksilont on 25.05.2022.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle().fill(Colors.IndicatorKnob)
            Circle().stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
