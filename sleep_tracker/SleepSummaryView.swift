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
                    
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 170, height: 170)
                                .foregroundStyle(.blue)

                            Circle()
                                .frame(width: 120, height: 120)
                                .foregroundStyle(Color(.systemGray5))
                            
                            Text("86")
                                .bold()
                                .font(.system(size: 40))
                        }
                        .padding()
                        
//                        Spacer()
//                            .frame(maxWidth: .infinity)
//                            .frame(maxHeight: .infinity)
                        
                        VStack(alignment: .leading) {
                            Text("Dauer: 8:12 h")
                            Text("Tiefe: 1:43 h")
                            Text("Leicht: 5:32 h")
                            Text("REM: 0:32 h")
                            Text("Wach: 0:32 h")
                            Text("Unruhige Momente: 12")
                        }
                        
                        Spacer()
                    }
                    .background(Color(.systemGray5).cornerRadius(20))
                    .frame(height: 180)
                    .padding(.horizontal)
                }
        
                
                LazyVGrid(columns: columns, spacing: 10) {
                    GroupBox {
                        VStack {
                            HStack {
                                Text("Durch. HFQ")
                                    .bold()
                                Spacer()
                                Text("63")
                                    .font(.system(size: 20))
                                    .bold()
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            Divider()
                            Spacer()

                            Chart {
                                BarMark(x: .value("Time", 1), yStart: .value("Test", 54), yEnd: .value("Test", 61))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 2), yStart: .value("Test", 60), yEnd: .value("Test", 70))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 3), yStart: .value("Test", 63), yEnd: .value("Test", 73))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 4), yStart: .value("Test", 57), yEnd: .value("Test", 67))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 5), yStart: .value("Test", 59), yEnd: .value("Test", 67))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 6), yStart: .value("Test", 60), yEnd: .value("Test", 64))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 7), yStart: .value("Test", 60), yEnd: .value("Test", 64))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 8), yStart: .value("Test", 60), yEnd: .value("Test", 64))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                BarMark(x: .value("Time", 9), yStart: .value("Test", 63), yEnd: .value("Test", 69))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                RuleMark(xStart: .value("", 0),
                                         xEnd: .value("", 10),
                                         y: .value("Test2", 63))
                                .annotation(position: .trailing) {
                                    Text("63").bold()
                                }
                                
                                RuleMark(xStart: .value("", 2),
                                         xEnd: .value("", 4),
                                         y: .value("Test2", 73.5))
                                .annotation(position: .top) {
                                    Text("Max: 73")
                                        .bold()
                                        .font(.system(size: 10))
                                        .offset(x: 0, y: 2)
                                }
                                
                                RuleMark(xStart: .value("", 0),
                                         xEnd: .value("", 2),
                                         y: .value("Test2", 53.5))
                                .annotation(position: .bottom) {
                                    Text("Min: 54").font(.system(size: 10)).bold().offset(x: 0, y: -2)
                                }
                            }
                            .chartXAxis(.hidden)
                            .chartYAxis(.hidden)
                            .chartYScale(domain: 54...78)
                            .frame(maxWidth: 135)
                            .foregroundStyle(.red)
                            
                            
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                    }
                    .backgroundStyle(Color(.systemGray5))
                    .frame(height: 180)
                    .cornerRadius(20)
                    
                //MARK: - Box 2
                GroupBox {
                    VStack {
                        HStack {
                            Text("Hypnogram")
                                .bold()
//                            Spacer()
//                            Text("63")
//                                .font(.system(size: 20))
//                                .bold()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        Divider()
                        Spacer()

                        Chart {
                            BarMark(xStart: .value("Time", 0),
                                    xEnd: .value("Time", 2),
                                    y: .value("Test", "Awake"))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                            BarMark(xStart: .value("Time", 2),
                                    xEnd: .value("Time", 6),
                                    y: .value("Test", "Asleep"))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                            BarMark(xStart: .value("Time", 6),
                                    xEnd: .value("Time", 7),
                                    y: .value("Test", "Awake"))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                            BarMark(xStart: .value("Time", 7),
                                    xEnd: .value("Time", 9),
                                    y: .value("Test", "Asleep"))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            
//                            RectangleMark(
//                                xStart: .value("Rect Start Width", 6),
//                                xEnd: .value("Rect End Width", 8),
//                                yStart: .value("Rect End Height", "Awake"),
//                                yEnd: .value("test", "Awake")
//                            )
//                            .opacity(0.2)
//                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                            
                            RectangleMark(
                                xStart: .value("Rect Start Width", 0),
                                xEnd: .value("Rect End Width", 5.2),
                                yStart: .value("Rect End Height", "Awake"),
                                yEnd: .value("test", "Awake")
                            )
                            .opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
//                        .chartXAxis(.hidden)
//                        .chartYAxis(.hidden)
//                        .chartYScale(domain: ["Awake", "Asleep"])
//                        .frame(maxWidth: 135)
//                        .foregroundStyle(Color(.cyan))
//                        .mask {
//                            LinearGradient(
//                                colors: [.green, .yellow],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        }
                        
                        
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                }
                .backgroundStyle(Color(.systemGray5))
                .frame(height: 180)
                .cornerRadius(20)
            
                    
                }
                .padding(.horizontal)
            
                
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
