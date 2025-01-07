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
                let sleepDuration = rawData.sleepDuration
                let averageDurationLast7Days: Double = Double(rawData.sleepDuration.filter {$0.key > Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date.now}.values.reduce(0, +) / Double(rawData.sleepDuration.filter {$0.key > Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date.now}.count))
                let lastNightBedtime = rawData.bedtime.first(where: {Calendar.current.isDateInToday($0.key)})?.value.formatted(.dateTime)
                let lastNightWakeTime = rawData.wakeTime.first(where: {Calendar.current.isDateInToday($0.key)})?.value.formatted(.dateTime)
                let lastNightSleepDuration = rawData.sleepDuration.first(where: {Calendar.current.isDateInToday($0.key)})?.value
                let durationChangeToAverageLast7Days = (lastNightSleepDuration ?? 0) - averageDurationLast7Days
                
                return SleepData(sleepDuration: sleepDuration, averageDurationLast7Days: averageDurationLast7Days, lastNightBedtime: lastNightBedtime ?? "", lastNightWakeTime: lastNightWakeTime ?? "", lastNightSleepDuration: lastNightSleepDuration ?? 0, durationChangeToAverageLast7Days: durationChangeToAverageLast7Days)
            }
            .eraseToAnyPublisher()
    }
}
