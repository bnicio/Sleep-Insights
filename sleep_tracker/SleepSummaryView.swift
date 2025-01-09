//
//  SleepSummaryView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import SwiftUI
import Charts

struct SleepData1: Identifiable {
    let id = UUID()
    let stage: String
    let start: Double
    let end: Double
}

struct SleepSummaryView: View {
    @StateObject private var viewModel = SleepViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    @State private var boxes = [
        Box(color: Color(.systemGray5), title: "Durchsch. Herzfrqrequenz", subTitle: "63"),
        Box(title: "7 Tage Durchschschnitt"),
        Box(title: "Box 3"),
        Box(title: "Box 4")
    ]
    
    let sleepData: [SleepData1] = [
        SleepData1(stage: "Awake", start: 0.0, end: 1.0),
        SleepData1(stage: "REM", start: 1.0, end: 2.5),
        SleepData1(stage: "Core", start: 2.5, end: 4.0),
        SleepData1(stage: "Deep", start: 4.0, end: 5.0)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink(destination: {
                    QuestionsView(questions: [])
                }, label: {
                    VStack(alignment: .leading) {
                        Text("Täglichen Fragebogen ausfüllen")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 40)
                    .background(Color(.blue).clipShape(RoundedRectangle(cornerRadius:10)))
                    .padding(.horizontal)
                    .padding(.vertical)
                })
                
                //MARK: - Box 1
                
                VStack(alignment: .leading) {
                    Text("Diese Nacht").bold().padding(.leading)
                        .font(.system(size: 18))
                        .offset(y: 6)
                    
                    BigBoxView()
                        .background(Color(.systemGray5).cornerRadius(20))
                        .frame(height: 180)
                        .padding()
                }
        
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    NavigationLink(destination: {
                        HFQView()
                            .navigationTitle("Herzfrequenz")
                    }, label: {
                        BoxHFRQView()
                    })
                        .backgroundStyle(Color(.systemGray5))
                        .frame(height: 180)
                        .cornerRadius(20)
                        .buttonStyle(.plain)
                    
                    HypnoGramView()
                        .backgroundStyle(Color(.systemGray5))
                        .frame(height: 180)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                
                HStack (alignment: .top, content: {
                    Text("Letzen 7 Tage").bold().padding(.leading)
                    Spacer()
                })
                .padding(.vertical)
                
                HStack (alignment: .top, content: {
                    Text("Trends").bold().padding(.leading)
                    Spacer()
                })
                .padding(.vertical)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Lade Schlafdaten...")
                    } else if let sleepData = viewModel.sleepData {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("7 Tage Durchschnitt: \(formattedDuration(sleepData.averageDurationLast7Days))")
                            Text("Zu Bett Geh Zeit: \(sleepData.lastNightBedtime)")
                            Text("Aufwachzeit: \(sleepData.lastNightWakeTime)")
                            Text("Schlafdauer: \(sleepData.lastNightSleepDuration)")
                            Text("Sleep Time Change to Average: \(sleepData.durationChangeToAverageLast7Days)")
                            
                            GroupBox {
                                Text("SleepDuration Array Werte:")
                                ForEach(sleepData.sleepDuration.sorted{ $0.key > $1.key}, id: \.0) { (date, duration) in
                                    Text("\(formattedDate(date)): \(formattedDuration(duration))")
                                }
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
