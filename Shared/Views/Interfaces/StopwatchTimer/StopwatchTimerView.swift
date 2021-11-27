//
//  StopWatchTimerView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import SwiftUI

struct StopWatchTimerView: View {
    @StateObject var viewModel = StopWatchTimerViewModel()
    
    var body: some View {
        VStack(spacing: 64) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.66))
                    .neumorphicShadow(shadowIntensity: .veryStrong, radius: 4)
                
                Circle()
                    .fill(Color(.displayP3, red: 40/255, green: 40/255, blue: 40/255, opacity: 0.3))
                
                if let multiArcViewModel = viewModel.multiArcViewModel {
                    MultiArcView(viewModel: multiArcViewModel)
                        .padding(10)
                }
                
                if let timeViewModel = viewModel.timeViewModel {
                    TimeView(viewModel: timeViewModel, textColor: .black.opacity(0.95))
                        .frame(minWidth: 250, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity, alignment: .center)
                        .padding(50)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 1, lightColor: .orange, darkColor: .pink)
                        .neumorphicShadow(shadowIntensity: .mediumStrong, radius: 5, lightColor: .blue, darkColor: .purple, x: 5, y: 0)
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 90, lightColor: .green, darkColor: .blue, x: 0, y: 50)

                }
            }
            
            TimerControlsView(startAction: viewModel.start,
                              pauseAction: viewModel.pause,
                              stopAction: viewModel.stop)
        }
        .padding(20)
        .aspectRatio(0.85, contentMode: .fit)
        .animation(.interactiveSpring())
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = StopWatchTimerViewModel(timeKeeperService: TimeKeeperService())
        viewModel.start()
        return StopWatchTimerView(viewModel: viewModel)
            .previewLayout(.fixed(width: 400, height: 400))
            .background(Color(.displayP3, red: 20/255, green: 20/255, blue: 20/255, opacity: 0.66))
    }
}
