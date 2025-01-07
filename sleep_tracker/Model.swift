//
//  Model.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import Foundation

struct SleepData {
    let sleepDuration: [Date:Double]
    let averageDurationLast7Days: Double
    let lastNightBedtime: String
    let lastNightWakeTime: String
    let lastNightSleepDuration: Double
    let durationChangeToAverageLast7Days: Double
}

struct RawSleepData {
    let sleepDuration: [Date:Double]
    let bedtime: [Date:Date]
    let wakeTime: [Date:Date]
}
