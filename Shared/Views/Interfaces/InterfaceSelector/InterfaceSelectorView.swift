//
//  InterfaceSelector.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import SwiftUI

struct InterfaceSelector: View {
    @ObservedObject var viewModel: InterfaceSelectorViewModel
    
    var body: some View {
        VStack {
            HStack {
                if viewModel.selectedInterface == .clock{
                    ClockView(withViewModel: viewModel.clockViewModel)
                        .transition(.opacity)
                        .layoutPriority(1.0)
                }
                else if viewModel.selectedInterface == .stopWatch {
                    StopWatchTimerView(viewModel: viewModel.stopWatchViewModel)
                        .transition(.opacity)
                        .layoutPriority(1.0)
                }
            }

            SliderSwitch(viewModel: viewModel.sliderSwitchViewModel)
                .frame(maxWidth: .infinity, minHeight: 36, maxHeight: 56, alignment: .center)
                .padding(12)
        }
        .aspectRatio(0.85, contentMode: .fit)
        .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.78, blendDuration: 0.75))
    }
}

struct InterfaceSelector_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InterfaceSelectorViewModel()
        return InterfaceSelector(viewModel: viewModel)
    }
}
