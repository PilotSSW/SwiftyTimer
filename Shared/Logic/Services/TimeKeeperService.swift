//
//  TimeKeeper.swift
//  TimeKeeper
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import Foundation

enum TimeKeeperError: Error {
    case callerAlreadyRegistered(key: UUID)
    case callerNotFound(key: UUID)
}

class TimeKeeperService: ObservableObject {
    private var timer: Timer = Timer()
    private var subscriptions: [UUID: (callback: (() -> Void), allowsGlobalDispatchQueue: Bool)] = [:]
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            self.callRegisteredCallbacks()
        })
        timer.tolerance = 0.0025
    }
}

/// MARK: Public calling functions
extension TimeKeeperService {
    func registerTimerNotification(allowsGlobalDispatchQueue: Bool = false,
                                   _ callback: @escaping (() -> Void)) throws -> UUID {
        let key = UUID()
        
        if subscriptions[key] != nil {
            throw TimeKeeperError.callerAlreadyRegistered(key: key)
        }
        else {
            subscriptions[key] = (callback, allowsGlobalDispatchQueue)
        }
        
        return key
    }
    
    func unregisterCallback(withKey key: UUID) throws {
        if subscriptions[key] == nil {
            throw TimeKeeperError.callerNotFound(key: key)
        }
         
        subscriptions.removeValue(forKey: key)
    }
}


/// MARK: Private internal functions
extension TimeKeeperService {
    private func callRegisteredCallbacks() {
        subscriptions.forEach({
            let callback = $0.value.callback
            let allowsGlobalDispatchQueue = $0.value.allowsGlobalDispatchQueue
            
            let dispatchQueue = allowsGlobalDispatchQueue
                ? DispatchQueue.global(qos: .userInteractive)
                : DispatchQueue.main
            
            dispatchQueue.async {
                callback()
            }
        })
    }
}
