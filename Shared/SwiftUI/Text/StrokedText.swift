//
//  StrokedText.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation
import SwiftUI

#if os(macOS)
import AppKit
struct StrokedText: View {
    private var attributes: [NSAttributedString.Key : Any] {[
        .font: NSFont(name: "SF Pro", size: 260)!,
        .strokeWidth: -1.0,
        .strokeColor: NSColor.black,
        .foregroundColor: NSColor.blue]
    }
    
    @Binding var text: String
    
    init(_ text: String = "") {
        self.init(.constant(text))
    }
    
    init(_ text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        AttributedText(NSAttributedString(string: text,
                                          attributes: attributes))
//            .frame(minWidth: 10, idealWidth: 100, maxWidth: .infinity,
//                   minHeight: 10, idealHeight: 20, maxHeight: .infinity,
//                   alignment: .center)
    }
}
#elseif (iOS)
import UIKit
struct StrokedText: View {
    var body: some View {
        AttributedText(NSAttributedString(string: "@Todo"))
    }
}
#endif

struct StrokedText_Previews: PreviewProvider {
    static var previews: some View {
        StrokedText("Hello there!")
    }
}
