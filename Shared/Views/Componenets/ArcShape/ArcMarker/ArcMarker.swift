//
//  ArcMarker.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct ArcMarker: View {
    var lineLength: CGFloat = 20
    var marker: String = ""
    
    var body: some View {
        Marker(lineLength: lineLength)
            .stroke(lineWidth: 5)
    }
}

struct ArcMarker_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ArcMarker(lineLength: 40, marker: "Marker")
        }
            .previewLayout(.sizeThatFits)
    }
}
