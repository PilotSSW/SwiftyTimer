//
//  AngleHelper.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation
import struct SwiftUI.Angle

class AngleHelper {
    static func getEndingAngleOfProgressArc(startingAngle: Angle, totalAngle: Angle, progress: Double) -> Angle {
        let startingDegrees = startingAngle.degrees
        let arcInDegrees = totalAngle.degrees * progress
        let endingDegrees = startingDegrees + arcInDegrees
        
        return Angle(degrees: endingDegrees)
    }
}
