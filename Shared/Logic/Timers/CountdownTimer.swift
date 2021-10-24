//
//  CountdownTimer.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Foundation

public class CountdownTimer {
        // Tolerance heavily reduces the impact on the device by giving the clock some flexibility to fire it a bit late using timer coalescing
        // Please do not remove this.
    public static let timerTolerance: Double = 0.15  // Tolerance is 150 milliseconds
    
    private var timer: Timer?
    private var globalCount: Double
    private(set) var duration: Double
    private let refreshDuration: Double
    private let restartAfterFinish: Bool
    private let updateBlock: ((Double, Double, CountdownTimer?) -> ())? // ElapsedTime, RemainingTime, Self for reset() or stop() call in update block if needed
    private let finishBlock: ((Double) -> ())? // ElapsedTime
    
    init(duration: Double, refreshDuration: Double, restartAfterFinish: Bool = false, finishBlock: ((Double) -> ())?, updateBlock: ((Double, Double, CountdownTimer?) -> ())?) {
        self.globalCount = 0.0
        
        self.duration = duration
        self.refreshDuration = refreshDuration
        self.finishBlock = finishBlock
        self.updateBlock = updateBlock
        
        self.restartAfterFinish = restartAfterFinish
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    private func createNewUnderlyingTimer() {
            // This should only be called if the countdown timer is not already running.
            // If it is, it should ignore this call.
        guard timer == nil else {
            return
        }
        let timer = Timer(timeInterval: self.refreshDuration, target: self, selector: #selector(incrementTimer),
                          userInfo: nil, repeats: true)
        timer.tolerance = CountdownTimer.timerTolerance
        self.timer = timer
        
            // The timer should be added to the runloop in common mode so that the user
            // interacting with the UI does not block or stop the timer.
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc private func incrementTimer() {
        globalCount += refreshDuration
        
            // Case: Timer has reached the end and
        if globalCount >= duration {
            finishBlock?(globalCount)
            
            if restartAfterFinish {
                reset(runFor: duration,
                      shouldStart: true,
                      shouldResetElapsedTime: true)
            } else {
                stop()
            }
            
                // Case: Timer still has remaining time
        } else {
            updateBlock?(globalCount, remainingTime(), self)
        }
    }
    
    /**
     This will start a declared CountdownTimer instance. If the timer has already been started, this
     call wil do nothing. If this is called after the timer has been stopped with time remaining, it
     will continue where the timer was stopped.
     - Returns: Void`.
     */
    public func start() {
        createNewUnderlyingTimer()
    }
    
    /**
     This will stop a declared CountdownTimer instance. If the timer has already been stopped, this
     call wil do nothing.
     - Returns: Void`.
     */
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    /**
     This will reset a declared CountdownTimer instance. If the timer has already been stopped, this
     call wil do nothing.
     - Parameter runFor: The amount time the countdown timer should now run for.
     - Parameter shouldStart: Flag to set if this call to reset should automatically start the timer - Defaults to false.
     - Parameter shouldResetElapsedTime: Flag to set if the timer should keep track of elapsed time when resetting or start again from 0 - Defaults to true
     - Returns: Void`.
     */
    public func reset(runFor newDuration: Double?, shouldStart: Bool = false, shouldResetElapsedTime: Bool = true) {
        if timer?.isValid ?? true {
            stop()
        }
        
        if let newDuration = newDuration {
            self.duration = newDuration
        }
        
        if shouldResetElapsedTime {
            self.globalCount = 0.0
        }
        
        if shouldStart {
            start()
        }
    }
    
    func remainingTime() -> Double {
        duration - globalCount
    }
}
