//
//  DataManager.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import Foundation
import Combine

class DataManager {
    private let healthDataFetcher = HealthDataFetcher()
    
    func fetchSleepSummary() -> AnyPublisher<SleepData, Error> {
        print("DataManager -> fetchSleepSummary()")
        return healthDataFetcher.fetchSleepData()
            .map { rawData in
                // Verarbeite Rohdaten in ein SleepData-Modell
                let sleepDuration = rawData.first?.sleepDuration ?? [:]
                let averageDurationLast7Days: Double = Double(sleepDuration.values.reduce(0) { $0 + $1 })
                let bedtime = rawData.first?.bedtime ?? "Unbekannt"
                let wakeTime = rawData.first?.wakeTime ?? "Unbekannt"
                
                return SleepData(sleepDuration: sleepDuration,
                                 averageDurationLast7Days: averageDurationLast7Days,
                                 bedtime: bedtime,
                                 wakeTime: wakeTime)
            }
            .eraseToAnyPublisher()
    }
}
