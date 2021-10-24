//
//  InterfaceSelectorViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Combine
import Foundation

class InterfaceSelectorViewModel: ObservableObject {
    enum SelectedInterface {
        case clock
        case stopWatch
    }
    
    @Published var selectedInterface: SelectedInterface = .clock
    @Published var showMenu: Bool = false
}
