//
//  TimerControlsView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import SwiftUI

struct TimerControlsView: View {
    @State private var buttonWidth: CGFloat = 96
    @State private var buttonHeight: CGFloat = 72
    @State private var buttonCornerRadius: CGFloat = 24
    
    var startAction: (() -> Void) = {}
    var pauseAction: (() -> Void) = {}
    var stopAction: (() -> Void) = {}

    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            
            Button(action: startAction) {
                Text("Start")
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(color: .black.opacity(1.0), radius: 4, x: 0, y: 4)
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .blue, cornerRadius: buttonCornerRadius))
            
            Button(action: pauseAction) {
                Text("Pause")
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(color: .black.opacity(1.0), radius: 4, x: 0, y: 4)

            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .purple, cornerRadius: buttonCornerRadius))
            
            Button(action: stopAction) {
                Text("Stop")
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(color: .black.opacity(1.0), radius: 4, x: 0, y: 4)
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .red, cornerRadius: buttonCornerRadius))
            
            Spacer()
        }
        .font(.system(size: 32, weight: Font.Weight.thin, design: .rounded))
        .neumorphicShadow(shadowIntensity: .mediumStrong, radius: 5, lightColor: .white, darkColor: .gray)
    }
}

struct TimerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        TimerControlsView()
    }
}
