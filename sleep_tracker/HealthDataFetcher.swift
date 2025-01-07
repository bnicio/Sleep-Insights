//
//  HealthDataFetcher.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import Foundation
import HealthKit
import Combine

class HealthDataFetcher {
    private let healthStore = HKHealthStore()
    
    func fetchSleepData() -> Future<RawSleepData, Error> {
        Future { promise in
            print("HealthDataFetcher -> fetchSleepData()")
            
            let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
            let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
            
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let sleepSamples = results as? [HKCategorySample] else {
                    promise(.success(RawSleepData(sleepDuration: [:], bedtime: [:], wakeTime: [:])))
                    return
                }
                
                // Nur "inBed" Samples berücksichtigen
                let inBedSamples = sleepSamples.filter { $0.value == HKCategoryValueSleepAnalysis.inBed.rawValue }
                
                var sleepDurationByDate: [Date: Double] = [:]
                var bedtimeByDate: [Date: Date] = [:]
                var wakeTimeByDate: [Date: Date] = [:]
                
                let calendar = Calendar.current
                
                for sample in inBedSamples {

                    // Setze den Cutoff-Zeitpunkt auf 12:00 Uhr mittags
                    var sleepDateComponents = calendar.dateComponents([.year, .month, .day], from: sample.startDate)
                    sleepDateComponents.hour = 12
                    let cutoffDate = calendar.date(from: sleepDateComponents)!
                    
                    // Wenn der Startzeitpunkt vor 12 Uhr liegt, ordne ihn dem vorherigen Tag zu
                    let adjustedSleepDate: Date
                    if sample.startDate < cutoffDate {
                        adjustedSleepDate = calendar.date(byAdding: .day, value: -1, to: cutoffDate)!
                    } else {
                        adjustedSleepDate = cutoffDate
                    }

                    let durationInHours = sample.endDate.timeIntervalSince(sample.startDate) / 3600
                    
                    // Summiere die Schlafdauer
                    sleepDurationByDate[adjustedSleepDate, default: 0] += durationInHours
                    
                    // Speichere die früheste Zubettgehzeit und späteste Aufwachzeit
                    if bedtimeByDate[adjustedSleepDate] == nil || sample.startDate < bedtimeByDate[adjustedSleepDate]! {
                        bedtimeByDate[adjustedSleepDate] = sample.startDate
                    }
                    if wakeTimeByDate[adjustedSleepDate] == nil || sample.endDate > wakeTimeByDate[adjustedSleepDate]! {
                        wakeTimeByDate[adjustedSleepDate] = sample.endDate
                    }
                }
                
                let rawData = RawSleepData(
                    sleepDuration: sleepDurationByDate,
                    bedtime: bedtimeByDate,
                    wakeTime: wakeTimeByDate
                )
                
                promise(.success(rawData))
            }
            
            self.healthStore.execute(query)
        }
    }
    
    func requestAuthorization() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            if !success {
                print("Berechtigung fehlgeschlagen: \(String(describing: error))")
            }
        }
    }
}
