//
//  TimerApp.swift
//  Shared
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import SwiftUI

@main
struct TimerApp: App {
    let persistenceController = PersistenceController.shared
    
    let timeKeeperService = TimeKeeperService()
    
    #if os(macOS)
    @State private var window: NSWindow? 
    #endif

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ZStack {
                VisualEffectBlur(material: .ultraDark,
                                 blendingMode: .behindWindow,
                                 state: .active)
                    .ignoresSafeArea()
                
                Color(.displayP3, red: 20/255, green: 20/255, blue: 20/255, opacity: 0.5)
                    .ignoresSafeArea()

                ClockView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(timeKeeperService)
            }
            .background(WindowAccessor(window: $window))
            .frame(minWidth: 450, maxWidth: 1400, minHeight: 600, maxHeight: 1400)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        
        #else
        WindowGroup {
            ZStack {
                VisualEffectBlur(material: .underWindowBackground,
                                 blendingMode: .behindWindow,
                                 state: .active)
                
                TimerView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .frame(minWidth: 150, maxWidth: 1400, minHeight: 150, maxHeight: 1400)
        }
        #endif
    }
}
