//
//  ClockView.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct ClockView: View {
    @ObservedObject var viewModel: ClockViewModel
    
    init(withViewModel viewModel: ClockViewModel = ClockViewModel()) {
        self.viewModel = viewModel
        
    }
    
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
                
                if let clockViewModel = viewModel.timeViewModel {
                    TimeView(viewModel: clockViewModel, textColor: .black.opacity(0.95))
                        .padding(.vertical, 190)
                        .frame(minWidth: 250, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity, alignment: .center)
                        .neumorphicShadow(shadowIntensity: .tooFuckingStrong, radius: 1, lightColor: .orange, darkColor: .pink)
                        .neumorphicShadow(shadowIntensity: .veryStrong, radius: 5, lightColor: .blue, darkColor: .purple, x: 5, y: 0)
                        .neumorphicShadow(shadowIntensity: .strong, radius: 90, lightColor: .green, darkColor: .blue, x: 0, y: 50)
                    
                }
            }
        }
        .padding(20)
        .aspectRatio(0.85, contentMode: .fit)
        .animation(.interactiveSpring())
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
