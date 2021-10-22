//
//  TimerApp.swift
//  Shared
//
//  Created by Sean Wolford on 10/22/21.
//

import SwiftUI

@main
struct TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
