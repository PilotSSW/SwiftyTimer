//
//  ServiceContainer.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Foundation

final class ServiceContainer {
    private static let shared = ServiceContainer()
    
    let timeKeeperService = TimeKeeperService()

    private init() { }
    
    public static func get() -> ServiceContainer {
        return .shared
    }
}

