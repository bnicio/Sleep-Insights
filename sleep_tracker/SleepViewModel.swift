//
//  SleepViewModel.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 13.12.24.
//

import Foundation
import Combine

class SleepViewModel: ObservableObject {
    @Published var sleepData: SleepData?
    @Published var isLoading = false
    
    private let dataManager = DataManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchSleepData() {
        isLoading = true
        
        dataManager.fetchSleepSummary()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Fehler beim Abrufen der Daten: \(error)")
                }
            } receiveValue: { [weak self] sleepData in
                self?.sleepData = sleepData
            }
            .store(in: &cancellables)
    }
}
