//
//  SwiftUIExtensions.swift
//  Timer (iOS)
//
//  Created by Sean Wolford on 10/25/21.
//

import Foundation
import SwiftUI

extension SwiftUI.ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
