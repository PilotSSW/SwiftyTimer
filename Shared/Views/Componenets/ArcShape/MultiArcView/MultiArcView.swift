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
    @State var lineWidth: CGFloat = 20.0
    private var arcSpacing: CGFloat { lineWidth / 6 }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let size = geo.size
                let width = size.width
                let height = size.height
//            
//                if width < 500 {
//                    lineWidth = 15
//                }
//                else if width < 1000 {
//                    lineWidth = 20
//                }
//                else {
//                    lineWidth = 45
//                }
                
                if viewModel.timeComponents.contains(.week){
                    ArcView(progress: $viewModel.weekProgress, arcColor: .blue, arcWidth: lineWidth)
                        .frame(width: width,
                               height: height,
                               alignment: .center)
//                        .drawingGroup()
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
                }
                
                if viewModel.timeComponents.contains(.day){
                    ArcView(progress: $viewModel.dayProgress, arcColor: .purple, arcWidth: lineWidth)
                        .padding(.leading, lineWidth + arcSpacing)
                        .padding(.top, lineWidth + arcSpacing)
                        .frame(width: width - (lineWidth + arcSpacing),
                               height: height - (lineWidth + arcSpacing),
                               alignment: .center)
//                        .drawingGroup()
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
                }
                
                if viewModel.timeComponents.contains(.hour){
                    ArcView(progress: $viewModel.hoursProgress, arcColor: .pink, arcWidth: lineWidth)
                        .padding(.leading, 2 * (lineWidth + arcSpacing))
                        .padding(.top, 2 * (lineWidth + arcSpacing))
                        .frame(width: width - (2 * (lineWidth + arcSpacing)),
                               height: height - (2 * (lineWidth + arcSpacing)),
                               alignment: .center)
//                        .drawingGroup()
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
                }
                
                if viewModel.timeComponents.contains(.minute){
                    ArcView(progress: $viewModel.minutesProgress, arcColor: .green, arcWidth: lineWidth)
                        .padding(.leading, 3 * (lineWidth + arcSpacing))
                        .padding(.top, 3 * (lineWidth + arcSpacing))
                        .frame(width: width - (3 * (lineWidth + arcSpacing)),
                               height: height - (3 * (lineWidth + arcSpacing)),
                               alignment: .center)
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 2, y: 0)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 2)
                }
                
                if viewModel.timeComponents.contains(.second){
                    ArcView(progress: $viewModel.secondsProgress, arcColor: .yellow, arcWidth: lineWidth)
                        .padding(.leading, 4 * (lineWidth + arcSpacing))
                        .padding(.top, 4 * (lineWidth + arcSpacing))
                        .frame(width: width - (4 * (lineWidth + arcSpacing)),
                               height: height - (4 * (lineWidth + arcSpacing)),
                               alignment: .center)
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 2, lightColor: .blue, darkColor: .purple, x: 1, y: 0)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 8, lightColor: .green, darkColor: .orange, x: 0, y: 1)
                }
            }
            .animation(.interactiveSpring(response: 0.15, dampingFraction: 0.65, blendDuration: 0.667))
        }
    }
}

struct MultiArcView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MultiArcViewModel(withTime: Time.Amount(totalSeconds: 8973.333))
        return MultiArcView(viewModel: viewModel)
            .previewLayout(.fixed(width: 800, height: 800))
    }
}
