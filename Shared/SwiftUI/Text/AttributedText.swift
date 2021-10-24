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
struct AttributedText: View  {
    @State var size: CGSize = .zero
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    var body: some View {
        AttributedTextRepresentable(attributedString: attributedString, size: $size)
            .frame(width: size.width, height: size.height)
    }
    
    struct AttributedTextRepresentable: NSViewRepresentable {
        
        let attributedString: NSAttributedString
        @Binding var size: CGSize
        
        func makeNSView(context: Context) -> NSTextView {
            let textView = NSTextView()
            
            textView.textContainer!.widthTracksTextView = false
            textView.textContainer!.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textView.drawsBackground = false
            
            return textView
        }
        
        func updateNSView(_ nsView: NSTextView, context: Context) {
            nsView.textStorage?.setAttributedString(attributedString)
            
            DispatchQueue.main.async {
                size = nsView.textStorage!.size()
            }
        }
    }
}
#elseif os(iOS)
import UIKit
struct AttributedText: UIViewRepresentable {
    
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
#endif
