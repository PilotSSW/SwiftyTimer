//
//  TimeView.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import SwiftUI

struct TimeView: View {
    @ObservedObject var viewModel: TimeViewModel
    @State var textColor: Color
    
    init(viewModel: TimeViewModel,
         textColor: Color = Color(.displayP3, red: 220/255, green: 220/255, blue: 220/255, opacity: 1.0)) {
        self.viewModel = viewModel
        self.textColor = textColor
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(alignment: .center, spacing: 2) {
                if viewModel.timeComponents.contains(.month) {
                    Text("\(viewModel.month)/")
                }
                
                if viewModel.timeComponents.contains(.day) {
                    Text(viewModel.days)
                }
                
                if viewModel.timeComponents.contains(.year) {
                    Text("/\(viewModel.days) ")
                }
                
                if viewModel.timeComponents.contains(.week) {
                    Text("Week \(viewModel.week)")
                }
            }
            HStack(alignment: .center, spacing: 2) {
                if viewModel.timeComponents.contains(.hour) {
                    Text(viewModel.hours)
                    Text(":")
                }
                
                if viewModel.timeComponents.contains(.minute) {
                    Text(viewModel.minutes)
                    Text(":")
                }
                
                if viewModel.timeComponents.contains(.second) {
                    Text(viewModel.seconds)
                }
                
                if viewModel.timeComponents.contains(.millisecond) {
                    Text(viewModel.milliseconds)
                }
            }
        }
        .shadow(color: .white, radius: 1.5)
        .foregroundColor(textColor)
        .allowsTightening(true)
        .minimumScaleFactor(0.10)
        .font(.system(size: 140, weight: .bold, design: .rounded))
        .multilineTextAlignment(.center)
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        let time = Time.Amount(hours: 1, minutes: 45, seconds: 13, milliseconds: 1946)
        let viewModel = TimeViewModel(withTime: time)
        return TimeView(viewModel: viewModel)
            .previewLayout(.fixed(width: 200, height: 40))
    }
}
