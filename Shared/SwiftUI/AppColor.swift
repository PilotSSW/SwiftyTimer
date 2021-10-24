//
//  AppColor.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation
import SwiftUI

struct AppColor {
    /**
     * Shadows
     */
    public static var objectShadowDark: Color {
        Color(.displayP3, red: 20/255, green: 20/255, blue: 20/255, opacity: 1.0)
    }

    public static var objectShadowLight: Color {
        Color(.displayP3, red: 220/255, green: 220/255, blue: 220/255, opacity: 1.0)
    }

    public static var textShadow: Color {
        Color(.displayP3, red: 40/255, green: 40/255, blue: 40/255, opacity: 1.0)
    }
    
    /**
     * Text
     */
    public static var textBody: Color {
        Color(.displayP3, red: 220/255, green: 220/255, blue: 220/255, opacity: 1.0)
    }
}

struct AppGradients {
    public static func buttonOutlineGradient(isPressed: Bool = false) -> LinearGradient {
        var colors: [Color] {
            isPressed
            ? [.white.opacity(0.6), .black.opacity(0.8)]
            : [.black.opacity(0.8), .white.opacity(0.6)]
        }
        
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
