//
//  PieSliceData.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import SwiftUI

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
    
    init(startAngle: Angle, endAngle: Angle, text: String = "", color: Color) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.text = text
        self.color = color
    }
}
