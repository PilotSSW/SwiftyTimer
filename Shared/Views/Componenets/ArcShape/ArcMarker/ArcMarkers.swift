//
//  ArcMarkers.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct ArcMarkers: View {
    var markerCount: Int
    var totalRange: Angle = .degrees(300)
    
    var body: some View {
//        ZStack {
//            ForEach(values: 0..<markerCount) { index in
//                let rotation: Double = index == 0
//                    ? 0.0
//                    : Double(totalRange.degrees / (index / markerCount))
//
//                Marker(lineLength: 2)
//                    .rotationEffect(.degrees(rotation))
//            }
//        }
        Text("")
    }
}

struct ArcMarkers_Previews: PreviewProvider {
    static var previews: some View {
        ArcMarkers(markerCount: 7)
            .frame(width: 200, height: 200, alignment: .center)
    }
}
