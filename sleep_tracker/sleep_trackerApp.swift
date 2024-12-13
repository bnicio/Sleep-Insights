//
//  sleep_trackerApp.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 08.11.24.
//

import SwiftUI

@main
struct sleep_trackerApp: App {
    private let healthDataFetcher = HealthDataFetcher()
    var body: some Scene {
        WindowGroup {
            SleepSummaryView()
                .onAppear {
                    healthDataFetcher.requestAuthorization()
                }
        }
    }
}
