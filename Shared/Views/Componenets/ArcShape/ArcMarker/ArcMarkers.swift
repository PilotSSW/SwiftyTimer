//
//  ArcMarkers.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct ArcMarkers: View {
    @State var markers: [Any] = []
    
    var body: some View {
        ZStack {
            ForEach(Array(markers.enumerated()), id: \.offset) { (index, marker) in
                ArcMarker(marker: "\(marker)", totalMarkers: markers.count)
            }
        }
    }
}

struct ArcMarkers_Previews: PreviewProvider {
    static var previews: some View {
        ArcMarkers(markers: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"])
    }
}
