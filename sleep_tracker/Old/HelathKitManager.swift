////
////  HelathKitManager.swift
////  sleep_tracker
////
////  Created by Benicio Nell on 09.11.24.
////
//import HealthKit
//import Foundation
//import Combine
//
//class HealthKitManager: ObservableObject {
//    let healthStore = HKHealthStore()
//    @Published var sleepSamples: [HKCategorySample] = []
//    
//    init() {
//        let sleep = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
//        
//        let healthTypes: Set = [sleep]
//        
//        Task {
//            do {
//                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
//            } catch {
//                print("Error catching data: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func retrieveSleepAnalysis() {
//        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
//            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//            
//            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 200, sortDescriptors: [sortDescriptor]) { [weak self] (query, tmpResult, error) -> Void in
//                
//                guard let self = self else { return }
//                
//                if error != nil {
//                    print("Error fetching sleep data: \(error!.localizedDescription)")
//                    return
//                }
//                
//                if let result = tmpResult {
//                    DispatchQueue.main.async {
//                        self.sleepSamples = result.compactMap { $0 as? HKCategorySample }
//                    }
//                }
//            }
//            
//            healthStore.execute(query)
//        }
//    }
//}
