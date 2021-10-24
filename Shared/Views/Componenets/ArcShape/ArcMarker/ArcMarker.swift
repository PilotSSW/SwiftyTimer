//
//  ArcMarker.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct ArcMarker: View {
    @State var marker: String
    @State var totalMarkers: Int
    
    var body: some View {
//        VStack() {
//            Text(marker)
//                .rotationEffect(.degrees(-360 / Double(totalMarkers) * Double(index)))
//            Spacer()
//        }
//        .padding()
//        .rotationEffect(.degrees(360 / Double(totalMarkers) * Double(index)))
        Text("")
    }
}

struct ArcMarker_Previews: PreviewProvider {
    static var previews: some View {
        ArcMarker(marker: "Marker", totalMarkers: 4)
    }
}
