//
//  ArcView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import Foundation
import SwiftUI

struct ArcView: View {
    @Binding var completionAmount: CGFloat
    @State var arcColor: Color
    @State var arcWidth: CGFloat
    
    private var startingAngle: Angle { .degrees(-240) }
    private var endingAngle: Angle { .degrees(60) }
    private var fillAngle: Angle {
        AngleHelper.getEndingAngleOfProgressArc(startingAngle: startingAngle,
                                                totalAngle: endingAngle - startingAngle,
                                                progress: (completionAmount.toDouble() / 100))
    }
    
    init(progress: Binding<CGFloat>, arcColor: Color = .pink, arcWidth: CGFloat = 20) {
        self._completionAmount = progress
        self.arcColor = arcColor
        self.arcWidth = arcWidth
    }
    
    var body: some View {
        ZStack {
            Arc(startAngle: startingAngle,
                endAngle: endingAngle,
                clockwise: false)
                .stroke(Color(.displayP3, white: 0.25, opacity: 0.9), style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .miter))
                .padding(arcWidth / 2)
            
            Arc(startAngle: startingAngle,
                endAngle: fillAngle,
                clockwise: false)
                .stroke(arcColor, style: StrokeStyle(lineWidth: arcWidth, lineCap: .round, lineJoin: .miter))
                .padding(arcWidth / 2)
            
            ArcMarkers(markerCount: 7)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#if DEBUG
struct Arc_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.opacity(0.66)
            ArcView(progress: .constant(65))
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 5, lightColor: .blue, darkColor: .purple, x: 10, y: 0)
                .neumorphicShadow(shadowIntensity: .medium, radius: 20, lightColor: .green, darkColor: .orange, x: 0, y: 10)
                .padding(15)
        }
    }
}
#endif
