////
////  ContentView.swift
////  sleep_tracker
////
////  Created by Benicio Nell on 08.11.24.
////
//
//import SwiftUI
//import Charts
//import HealthKit
//import Combine
//
//struct ContentView: View {
//    @StateObject private var viewModel = ContentViewModel()
//    private let gridItemLayout = Array(repeating: GridItem(spacing: 20), count: 2)
//    
//    var body: some View {
//        ScrollView {
//            HStack {
//                Text("Good Morning.")
//                    .font(.title)
//                    .fontWeight(.bold)
//                
//                Spacer()
//            }
//            
//            WeekSleepChart()
//                .onAppear {
//                    viewModel.refreshData()
//                }
//            
//            GeometryReader { geometry in
//                LazyVGrid(columns: gridItemLayout) {
//
//                    GroupBox(label: Text("Sleep Consistancy")) {
//                        Text("3 🔥")
//                            .font(.system(size: 50))
//                            .padding()
//                            .frame(maxHeight: .infinity)
//                    }
//                    .frame(width: geometry.size.width / 2)                    .frame(height: geometry.size.width / 2)
//                    
//                    GroupBox(label: Text("Average Sleeptime")) {
//                        Text(viewModel.averageTime)
//                            .font(.system(size: 20))
//                            .padding()
//                            .frame(maxHeight: .infinity)
//                        
//                    }
//                    .frame(width: geometry.size.width / 2)
//                    .frame(height: geometry.size.width / 2)
//                }
//            }
//            .padding(5)
//            
////            Text("Schlafproben der letzten 7 Nächte:")
////                .font(.headline)
////            ForEach(viewModel.sleepTimePerDay, id: \.date) {
////                Text($0.date.formatted(.dateTime) + $0.totalSleepTime.formatted())
////            }
//            
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
