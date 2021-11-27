//
//  MultiArcLabel.swift
//  Timer
//
//  Created by Sean Wolford on 10/25/21.
//

import SwiftUI

struct MultiArcLabel: View {
    var labels: [String]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.white)
                      
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.black.opacity(0.9))
            
            HStack() {
                ForEach(values: labels) { label in
                    Text(label)
                        .padding(.horizontal, 1)
                }
            }
            .layoutPriority(1)
        }
        .neumorphicShadow(shadowIntensity: .light, radius: 1, lightColor: .blue, darkColor: .black)
        .padding(3)
    }
}

struct MultiArcLabel_Previews: PreviewProvider {
    static var previews: some View {
        MultiArcLabel(labels: ["W", "D", "H", "M", "S"])
    }
}
