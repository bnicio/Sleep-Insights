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
        return healthDataFetcher.fetchSleepData()
            .map { rawData in
                // Verarbeite Rohdaten in ein SleepData-Modell
                let averageDuration = rawData.map { $0.duration }.reduce(0, +) / Double(rawData.count)
                let bedtime = rawData.first?.bedtime ?? "Unbekannt"
                let wakeTime = rawData.first?.wakeTime ?? "Unbekannt"
                
                return SleepData(averageDuration: averageDuration, bedtime: bedtime, wakeTime: wakeTime)
            }
            .eraseToAnyPublisher()
    }
}
