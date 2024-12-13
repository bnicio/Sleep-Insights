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
    let bedtime: String
    let wakeTime: String
}

struct RawSleepData {
    let sleepDuration: [Date:Double]
    let bedtime: String
    let wakeTime: String
}
