//
//  TimerControlsView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import SwiftUI

struct TimerControlsView: View {
    @State private var buttonWidth: CGFloat = 90
    @State private var buttonHeight: CGFloat = 90
    @State private var buttonCornerRadius: CGFloat = 18
    
    var startAction: (() -> Void) = {}
    var pauseAction: (() -> Void) = {}
    var stopAction: (() -> Void) = {}

    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            Button(action: startAction) {
                Text("Start")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .blue, cornerRadius: buttonCornerRadius))
            .neumorphicShadow(shadowIntensity: .mediumStrong, radius: 5, lightColor: .white, darkColor: .gray)
            
            Button(action: pauseAction) {
                Text("Pause")
                    .frame(width: buttonWidth, height: buttonHeight)

            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .purple, cornerRadius: buttonCornerRadius))
            .neumorphicShadow(shadowIntensity: .mediumStrong, radius: 5, lightColor: .white, darkColor: .gray)
            
            Button(action: stopAction) {
                Text("Stop")
                    .frame(width: buttonWidth, height: buttonHeight)
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .red, cornerRadius: buttonCornerRadius))
            .neumorphicShadow(shadowIntensity: .mediumStrong, radius: 5, lightColor: .white, darkColor: .gray)
            
            Spacer()
        }
        .font(.system(size: 32, weight: Font.Weight.thin, design: .rounded))
    }
}

struct TimerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        TimerControlsView()
    }
}
