//
//  SwiftExtensions.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation
import struct SwiftUI.CGFloat

extension CGFloat {
    func toDouble() -> Double {
        Double(self)
    }
}

public extension OptionSet where RawValue: FixedWidthInteger {
    
    func elements() -> AnySequence<Self> {
        var remainingBits = rawValue
        var bitMask: RawValue = 1
        return AnySequence {
            return AnyIterator {
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2 }
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                    }
                }
                return nil
            }
        }
    }
}

extension String {
    init(_ optionalParam: Any?) {
        self = ""
    }
}
