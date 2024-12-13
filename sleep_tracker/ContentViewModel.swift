//
//  ContentViewModel.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 18.11.24.
//
import Foundation
import Combine
import HealthKit

class ContentViewModel: ObservableObject {
    @Published var sleepStartTime: [(Date, Double)] = []
    @Published var sleepDuration: [(Date, Double)] = []
    
    private var healthKitManager = HealthKitManager()
    private var cancellables = Set<AnyCancellable>()
        
    init() {
        // Beobachten, wenn HealthKitManager Daten aktualisiert
        healthKitManager.$sleepSamples
            .receive(on: DispatchQueue.main)
            .sink { [weak self] samples in
                let sleepRecords = self?.calculateSleepTimePerDay(from: samples)
                self?.sleepTimePerDay = sleepRecords ?? []
                self?.updateSleepSamplesStrings(from: samples)
                self?.updateAverageTime()
            }
            .store(in: &cancellables)
    }
    
    func fetchSleepData() {
        healthKitManager.retrieveSleepAnalysis()
    }
    
    func calculateAverageSleepTime(sleepRecords: [SleepRecord]) -> Double? {
        guard !sleepRecords.isEmpty else {
            return nil
        }
        
        let totalSleepTime = sleepRecords.reduce(0.0) { total, record in
            return total + record.totalSleepTime
        }
        
        return totalSleepTime / Double(sleepRecords.count)
    }
    
    private func calculateSleepTimePerDay(from samples: [HKCategorySample]) -> [SleepRecord] {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        let relevantTimes = samples.filter { sample in
            let isRelevantCategory = sample.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue ||
            sample.value == HKCategoryValueSleepAnalysis.asleepDeep.rawValue ||
            sample.value == HKCategoryValueSleepAnalysis.asleepCore.rawValue
            let isWithinLast7Days = sample.startDate >= sevenDaysAgo
            return isRelevantCategory && isWithinLast7Days
        }
        
        var sleepRecords: [SleepRecord] = []
        
        // Gruppiere die Samples nach Datum (ignoriere die Uhrzeit)
        let groupedByDate = Dictionary(grouping: relevantTimes) { (sample: HKCategorySample) -> Date in
            // Wir extrahieren das Datum ohne die Uhrzeit
            return Calendar.current.startOfDay(for: sample.startDate)
        }
        
        // Berechne die Gesamtschlafzeit für jedes Datum
        for (date, samplesOnDate) in groupedByDate {
            let totalSleepTime = samplesOnDate.reduce(0.0) { total, sample in
                return total + sample.endDate.timeIntervalSince(sample.startDate)
            }
            
            // Füge das Ergebnis zu unserer Liste hinzu
            sleepRecords.append((date: date, totalSleepTime: totalSleepTime))
        }
        
        print(sleepRecords)
        return sleepRecords
    }
    
    func calculateAverageSleepTime(from sleepRecords: [SleepRecord]) -> Double? {
        guard !sleepRecords.isEmpty else {
            return nil
        }
        
        let totalSleepTime = sleepRecords.reduce(0.0) { total, record in
            return total + record.totalSleepTime
        }
        
        return totalSleepTime / Double(sleepRecords.count)
    }
    
    func secondsToHoursMinutes(_ seconds: Double) -> String {
        if seconds == -1 {return "Error"}
        
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        return hours.formatted() + ":" + minutes.formatted() + " Hours"
    }
}
