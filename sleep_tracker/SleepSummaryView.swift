//
//  SleepSummaryView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import SwiftUI

struct SleepSummaryView: View {
    @StateObject private var viewModel = SleepViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Lade Schlafdaten...")
                } else if let sleepData = viewModel.sleepData {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Durchschnittliche Schlafdauer: \(sleepData.averageDuration) Stunden")
                        Text("Zu Bett Geh Zeit: \(sleepData.bedtime)")
                        Text("Aufwachzeit: \(sleepData.wakeTime)")
                    }
                    .padding()
                } else {
                    Text("Keine Schlafdaten verfügbar.")
                }
            }
            .navigationTitle("Schlafübersicht")
            .onAppear {
                viewModel.fetchSleepData()
            }
        }
    }
}

#Preview {
    SleepSummaryView()
}
