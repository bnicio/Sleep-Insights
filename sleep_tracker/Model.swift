//
//  Model.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import Foundation

struct SleepData {
    let averageDuration: Double
    let bedtime: String
    let wakeTime: String
}

struct RawSleepData {
    let duration: Double
    let bedtime: String
    let wakeTime: String
}
