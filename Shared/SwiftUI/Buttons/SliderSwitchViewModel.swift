//
//  SliderSwitchViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/25/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat

class SliderSwitchViewModel: ObservableObject {
    @Published private(set) var options: [SliderOption] = []
    @Published var selectedIndex: Int = 0
    
    @Published var selectedButtonXPosition: CGFloat = 60.0
    
    init(withOptions options: [SliderOption] = []) {
        setOptions(options)
    }
    
    func optionWasSelectedAt(index selectedIndex: Int) {
        options.enumerated().forEach({ (currentIndex, option) in
            let selectedIndexIsCurrentIndex = currentIndex == selectedIndex
            
            option.isSelected = selectedIndexIsCurrentIndex
            
            selectedIndexIsCurrentIndex
                ? option.onSelect()
                : option.onDeselect?()
        })
        
        selectedButtonXPosition = CGFloat((selectedIndex + 1) * 128) - 68
    }
    
    func setOptions(_ options: [SliderOption]) {
        self.options = options
        
        let noneSelected = options.allSatisfy({ !$0.isSelected })
        if noneSelected, let firstOption = options.first {
            firstOption.isSelected = true
            selectedIndex = 0
        }
        else {
            selectedIndex = options.enumerated()
                .filter({ $0.element.isSelected })
                .first?
                .offset ?? 0
        }
    }
}

/// MARK: Slider Option Class Object
extension SliderSwitchViewModel {
    class SliderOption: ObservableObject, Identifiable, Hashable {
        static func == (lhs: SliderSwitchViewModel.SliderOption, rhs: SliderSwitchViewModel.SliderOption) -> Bool {
            lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(labelName)
        }
        
        internal let id = UUID()
        @Published var labelName: String = ""
        @Published var isSelected: Bool = false
        @Published var onSelect: (() -> Void) = {}
        @Published var onDeselect: (() -> Void)? = {}
        
        init(labelName: String,
             isSelected: Bool = false,
             onSelect: @escaping (() -> Void) = {},
             onDeselect: (() -> Void)? = nil) {
            self.labelName = labelName
            self.isSelected = isSelected
            self.onSelect = onSelect
            self.onDeselect = onDeselect
        }
    }
}
