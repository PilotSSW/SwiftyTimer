//
//  InterfaceSelectorViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Combine
import Foundation

class InterfaceSelectorViewModel: ObservableObject {
    enum SelectedInterface: String, CaseIterable {
        case clock = "Clock"
        case stopWatch = "Stop-Watch"
    }
    
    @Published var selectedInterface: SelectedInterface = .clock
    @Published var showMenu: Bool = false
    
    @Published var sliderSwitchViewModel: SliderSwitchViewModel
    
    @Published var clockViewModel = ClockViewModel()
    @Published var stopWatchViewModel = StopWatchTimerViewModel()
    
    init() {
        sliderSwitchViewModel = SliderSwitchViewModel()
        sliderSwitchViewModel.setOptions(selectedInterfacesMappedToSliderOptions())
    }
}

/// MARK: Private functions
extension InterfaceSelectorViewModel {
    private func selectedInterfacesMappedToSliderOptions() -> [SliderSwitchViewModel.SliderOption] {
        var sliderOptions = [SliderSwitchViewModel.SliderOption]()
        
        for option in SelectedInterface.allCases {
            let onSelect = { [weak self] in
                guard let self = self else { return }
                self.selectedInterface = option
            }
            let sliderOption = SliderSwitchViewModel.SliderOption(labelName: option.rawValue,
                                                                  onSelect: onSelect)
            sliderOptions.append(sliderOption)
        }
        
        return sliderOptions
    }
}
