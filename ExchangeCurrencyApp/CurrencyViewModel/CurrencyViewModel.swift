//
//  CurrencyViewModel.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import Foundation
import Combine

class CurrencyViewModel: ObservableObject {
    @Published var rates: [CurrencyRate] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchRates() {
        NetworkManager.shared.fetchRates()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to fetch rates: \(error)")
                }
            }, receiveValue: { [weak self] rates in
                guard let self = self else { return }
                self.rates = rates
            })
            .store(in: &cancellables)
    }
}
