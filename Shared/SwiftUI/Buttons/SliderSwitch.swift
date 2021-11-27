//
//  SliderSwitch.swift
//  Timer
//
//  Created by Sean Wolford on 10/25/21.
//

import SwiftUI

struct SliderSwitch: View {
    @ObservedObject var viewModel: SliderSwitchViewModel
    
    var body: some View {
        ZStack {
            let xPos = $viewModel.selectedButtonXPosition.wrappedValue
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.displayP3, red: 15/255, green: 85/255, blue: 205/255, opacity: 1.0))
                .frame(width: 120, height: 37)
                .position(x: xPos,
                          y: 37 / 2)
                .neumorphicShadow(shadowIntensity: .medium, radius: 6, lightColor: .white, darkColor: .black)
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.displayP3, red: 205/255, green: 205/255, blue: 205/255, opacity: 0.5))
                .frame(width: 120, height: 37)
                .position(x: xPos,
                          y: 37 / 2)
                
            HStack(spacing: 8) {
                ForEach(Array(zip(viewModel.options.indices, viewModel.options)), id: \.0) { index, option in
                    Button(action: {
                        viewModel.optionWasSelectedAt(index: index)
                    }, label: {
                        Text(option.labelName)
                            .font(.title2)
                            .padding(8)
                            .frame(width: 120)
                    })
                        .buttonStyle(NeumorphicButtonStyle(backgroundColor: Color(.displayP3, white: 0.88, opacity: 0.15)))
                }
            }
            .layoutPriority(1)
        }
        .padding(8)
        .animation(.interactiveSpring())
    }
}

struct SliderSwitch_Previews: PreviewProvider {
    static var previews: some View {
        let options: [SliderSwitchViewModel.SliderOption] = [
            SliderSwitchViewModel.SliderOption(labelName: "Option 1", isSelected: true),
            SliderSwitchViewModel.SliderOption(labelName: "Option 2"),
            SliderSwitchViewModel.SliderOption(labelName: "Option 3"),
            SliderSwitchViewModel.SliderOption(labelName: "Option 4")
        ]
        let vm = SliderSwitchViewModel(withOptions: options)
        return SliderSwitch(viewModel: vm)
    }
}
