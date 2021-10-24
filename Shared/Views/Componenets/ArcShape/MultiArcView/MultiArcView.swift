//
//  MultiArcView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import SwiftUI

struct MultiArcView: View {
    @ObservedObject var viewModel: MultiArcViewModel
    
    var body: some View {
        ZStack {
            ArcView(progress: $viewModel.weekProgress, arcColor: .green, arcWidth: 26)
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
            
            ArcView(progress: $viewModel.dayProgress, arcColor: .orange, arcWidth: 20)
                .scaleEffect(0.95, anchor: .center)
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
            
            ArcView(progress: $viewModel.hoursProgress, arcColor: .pink, arcWidth: 14)
                .scaleEffect(0.9, anchor: .center)
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
            
            ArcView(progress: $viewModel.minutesProgress, arcColor: .blue, arcWidth: 8)
                .scaleEffect(0.85, anchor: .center)
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
            
            ArcView(progress: $viewModel.secondsProgress, arcColor: .purple, arcWidth: 5)
                .scaleEffect(0.83, anchor: .center)
                .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 1, y: 0)
                .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 1)
        }
        .animation(.interactiveSpring(response: 0.15, dampingFraction: 0.35, blendDuration: 1.0))
    }
}

struct MultiArcView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MultiArcViewModel(withTime: Time.Amount(totalSeconds: 8973))
        return MultiArcView(viewModel: viewModel)
    }
}
