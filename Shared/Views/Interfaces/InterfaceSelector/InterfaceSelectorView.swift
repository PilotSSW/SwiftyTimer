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
        ZStack {
            ClockView()
        }
    }
}

struct InterfaceSelector_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InterfaceSelectorViewModel()
        return InterfaceSelector(viewModel: viewModel)
    }
}
