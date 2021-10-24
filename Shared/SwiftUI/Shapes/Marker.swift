//
//  Marker.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Foundation
import SwiftUI

struct Marker: Shape {
    @State var lineLength: CGFloat = 5
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + lineLength))
        return path
    }
}
