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

                InterfaceSelector(viewModel: InterfaceSelectorViewModel())
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
                Color(.displayP3, red: 35/255, green: 35/255, blue: 35/255, opacity: 1.0)
                    .edgesIgnoringSafeArea(.all)
                
                InterfaceSelector(viewModel: InterfaceSelectorViewModel())
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(timeKeeperService)
            }
            .frame(minWidth: 150, maxWidth: 1400, minHeight: 150, maxHeight: 1400)
        }
        #endif
    }
}
