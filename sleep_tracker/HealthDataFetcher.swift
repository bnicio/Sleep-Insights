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
    
    func fetchSleepData() -> AnyPublisher<[RawSleepData], Error> {
        Future { promise in
            print("HealthDataFetcher -> fetchSleepData()")
            
            let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
            let startDate = Calendar.current.date(byAdding: .day, value: -365, to: Date())!
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])
            
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let sleepSamples = results as? [HKCategorySample] else {
                    promise(.success([]))
                    return
                }
                
                let rawData = sleepSamples.map { sample -> RawSleepData in
                    // Schlüssel: Nur das Datum aus dem Startzeitpunkt extrahieren
                    let calendar = Calendar.current
                    let sleepDate = calendar.startOfDay(for: sample.startDate)
                    
                    // Wert: Dauer in Stunden
                    let durationInHours = sample.endDate.timeIntervalSince(sample.startDate) / 3600
                    
                    return RawSleepData(
                        sleepDuration: [sleepDate:durationInHours],
//                        duration: sample.endDate.timeIntervalSince(sample.startDate) / 3600,
                        bedtime: DateFormatter.localizedString(from: sample.startDate, dateStyle: .short, timeStyle: .short),
                        wakeTime: DateFormatter.localizedString(from: sample.endDate, dateStyle: .short, timeStyle: .short)
                    )
                }
                
                promise(.success(rawData))
            }
            
            self.healthStore.execute(query)
        }
        .eraseToAnyPublisher()
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
