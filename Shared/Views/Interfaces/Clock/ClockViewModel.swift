//
//  ClockViewModel.swift
//  Timer
//
//  Created by Sean Wolford on 10/23/21.
//

import Combine
import Foundation

class ClockViewModel: ObservableObject {
    var store = Set<AnyCancellable>()
    let timeKeeperService: TimeKeeperService
    private var serviceTag: UUID?
    
    @Published var time: Time.Amount
    @Published var multiArcViewModel: MultiArcViewModel?
    @Published var timeViewModel: TimeViewModel?
    
    init(timeKeeperService: TimeKeeperService = ServiceContainer.get().timeKeeperService) {
        self.timeKeeperService = timeKeeperService
        self.time = Time.Amount(totalSeconds: 0)
        
        start()
    }
    
    func start() {
        time = Time.Amount(totalSeconds: 0)
        multiArcViewModel = MultiArcViewModel(withTime: time)
        timeViewModel = TimeViewModel(withTime: time)
        
        do {
            serviceTag = try timeKeeperService.registerTimerNotification({ [weak self] in
                guard let self = self else { return }
                self.time.updateFromDate()
                self.multiArcViewModel?.updateViewOnTimeChange(self.time)
                self.timeViewModel?.updateViewOnTimeChange(self.time)
            })
        }
        catch (let error) {
            print("Fuck theres an error -> \(error.localizedDescription)")
        }
    }
    
    func stop() {
        pause()
        time = Time.Amount(totalSeconds: 0)
        multiArcViewModel = nil
        timeViewModel = nil
    }
}
