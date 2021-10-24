//
//  NeumorphicShadow.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation
import SwiftUI

struct NeumorphicShadow: ViewModifier {
    @State var shadowIntensity: ShadowIntensity
    @State var shouldRasterize: Bool = false
    
    @State var lightColor: Color
    @State var darkColor: Color
    
    var radius: CGFloat = 2
    var x: CGFloat = 1.33
    var y: CGFloat = 1.33
    
    init(shadowIntensity: ShadowIntensity = .light, radius: CGFloat = 2,
         lightColor: Color = .white, darkColor: Color = .black,
         xOffset: CGFloat = 1.33, yOffset: CGFloat = 1.33) {
        self.shadowIntensity = shadowIntensity
        self.radius = radius
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.x = xOffset
        self.y = yOffset
    }
    
    func body(content: Content) -> some View {
        let result = content
            .shadow(color: lightColor.opacity(shadowIntensity.rawValue),
                    radius: radius,
                    x: -x,
                    y: -y)
            .shadow(color: darkColor.opacity(shadowIntensity.rawValue),
                    radius: radius,
                    x: x,
                    y: y)
        
        if shouldRasterize {
            result.drawingGroup()
        }
        else {
            result
        }
    }
}

extension View {
    func neumorphicShadow(shadowIntensity: ShadowIntensity = .light, radius: CGFloat = 3,
                          lightColor: Color = .white, darkColor: Color = .black,
                          x: CGFloat = 1.33, y: CGFloat = 1.33) -> some View {
        self.modifier(NeumorphicShadow(shadowIntensity: shadowIntensity, radius: radius,
                                       lightColor: lightColor, darkColor: darkColor,
                                       xOffset: x, yOffset: y))
    }
}
