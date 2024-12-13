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
                        Text("7 Tage Durchschnitt: \(formattedDuration(sleepData.averageDurationLast7Days))")
                        Text("Zu Bett Geh Zeit: \(sleepData.bedtime)")
                        Text("Aufwachzeit: \(sleepData.wakeTime)")
                        Text("SleepDuration Array Werte:")
                        ForEach(sleepData.sleepDuration.sorted{ $0.key < $1.key}, id: \.0) { (date, duration) in
                            Text("\(formattedDate(date)): \(formattedDuration(duration))")
                        }
                    }
                    .padding()

                    Spacer()
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
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private func formattedDuration(_ duration: Double) -> String {
         let hours = Int(duration) // Ganzzahlige Stunden
         let minutes = Int((duration - Double(hours)) * 60) // Restliche Minuten
         return "\(hours) Stunden \(minutes) Minuten"
     }
}

#Preview {
    SleepSummaryView()
}
