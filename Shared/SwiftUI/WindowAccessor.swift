//
//  WindowAccessor.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import AppKit
import Foundation
import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.window = view.window
            self.window?.isOpaque = false
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
