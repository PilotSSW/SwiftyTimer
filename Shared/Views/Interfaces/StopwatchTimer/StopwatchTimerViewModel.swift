//
//  StopWatchTimerViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/22/21.
//

import Combine
import Foundation

class StopWatchTimerViewModel: ObservableObject {
    var store = Set<AnyCancellable>()
    let timeKeeperService: TimeKeeperService
    private var serviceTag: UUID?
    
    @Published var elapsedTime: Time.Amount
    @Published var multiArcViewModel: MultiArcViewModel?
    @Published var timeViewModel: TimeViewModel?
    @Published var runState: StopWatchState = .stopped
    
    init(timeKeeperService: TimeKeeperService = ServiceContainer.get().timeKeeperService) {
        self.timeKeeperService = timeKeeperService
        self.elapsedTime = Time.Amount(totalSeconds: 0)
    }
    
    func start() {
        if runState == .started { return }
        else if runState == .paused { }
        else {
            elapsedTime = Time.Amount(totalSeconds: 0.0)
            multiArcViewModel = MultiArcViewModel(withTime: elapsedTime, withTimeComponents: [.millisecond, .second, .minute, .hour, .day, .week])
            timeViewModel = TimeViewModel(withTime: elapsedTime)
        }
        
        registerServiceTag()
    }
    
    func pause() {
        unregisterServiceTag()
        runState = .paused
    }
    
    func stop() {
        unregisterServiceTag()
        elapsedTime = Time.Amount(totalSeconds: 0)
        multiArcViewModel = nil
        timeViewModel = nil
        runState = .stopped
    }
}

extension StopWatchTimerViewModel {
    enum StopWatchState {
        case stopped
        case started
        case paused
    }
    
    private func registerServiceTag() {
        do {
            serviceTag = try timeKeeperService.registerTimerNotification({ [weak self] timeInterval in
                guard let self = self else { return }
                let totalSecondsRun = self.elapsedTime.toSeconds() + timeInterval
                self.elapsedTime.updateFrom(totalSeconds: totalSecondsRun)
                self.multiArcViewModel?.updateViewOnTimeChange(self.elapsedTime)
                self.timeViewModel?.updateViewOnTimeChange(self.elapsedTime)
            })
        }
        catch (let error) {
            print("Fuck theres an error -> \(error.localizedDescription)")
        }
    }
    
    private func unregisterServiceTag() {
        if serviceTag == nil { return }
        do {
            if let serviceTag = serviceTag {
                try timeKeeperService.unregisterCallback(withKey: serviceTag)
                self.serviceTag = nil
            }
        }
        catch (let error) {
            print("Fuck theres an error -> \(error.localizedDescription)")
        }
    }
}
