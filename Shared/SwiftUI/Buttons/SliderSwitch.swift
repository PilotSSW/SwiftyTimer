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
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.displayP3, red: 15/255, green: 85/255, blue: 205/255, opacity: 1.0))
                .frame(width: 168, height: 50)
                .position(x: xPos,
                          y: 25)
                .neumorphicShadow(shadowIntensity: .medium, radius: 6, lightColor: .white, darkColor: .black)
            
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(.displayP3, red: 205/255, green: 205/255, blue: 205/255, opacity: 0.5))
                .frame(width: 168, height: 50)
                .position(x: xPos,
                          y: 25)
                
            HStack(spacing: 8) {
                ForEach(Array(zip(viewModel.options.indices, viewModel.options)), id: \.0) { index, option in
                    Button(action: {
                        viewModel.optionWasSelectedAt(index: index)
                    }, label: {
                        Text(option.labelName)
                            .font(.system(size: 28, weight: Font.Weight.thin, design: .rounded))
                            .padding(8)
                            .frame(width: 168)
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
        vm.optionWasSelectedAt(index: 2)
        return SliderSwitch(viewModel: vm)
    }
}
