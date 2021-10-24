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
    
    @Published var startTime: Date?
    @Published private var time: Time.Amount
    @Published var multiArcViewModel: MultiArcViewModel?
    @Published var timeViewModel: TimeViewModel?
    
    init(timeKeeperService: TimeKeeperService = ServiceContainer.get().timeKeeperService) {
        self.timeKeeperService = timeKeeperService
        self.time = Time.Amount(totalSeconds: 0)
    }
    
    func start() {
        startTime = Date()
        time = Time.Amount(totalSeconds: 0)
        multiArcViewModel = MultiArcViewModel(withTime: time)
        timeViewModel = TimeViewModel(withTime: time)
        
        do {
            serviceTag = try timeKeeperService.registerTimerNotification({ [weak self] in
                guard let self = self else { return }
                if let startTime = self.startTime {
                    self.time.updateFrom(totalSeconds: abs(startTime.timeIntervalSinceNow))
                    self.multiArcViewModel?.updateViewOnTimeChange(self.time)
                    self.timeViewModel?.updateViewOnTimeChange(self.time)
                }
            })
        }
        catch (let error) {
            print("Fuck theres an error -> \(error.localizedDescription)")
        }
    }
    
    func pause() {
        do {
            if let serviceTag = serviceTag {
                try timeKeeperService.unregisterCallback(withKey: serviceTag)
            }
        }
        catch (let error) {
            print("Fuck theres an error -> \(error.localizedDescription)")
        }
    }
    
    func stop() {
        pause()
        startTime = nil
        time = Time.Amount(totalSeconds: 0)
        multiArcViewModel = nil
        timeViewModel = nil
    }
}
