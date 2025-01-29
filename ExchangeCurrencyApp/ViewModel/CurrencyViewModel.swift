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
    @Published var favoriteRates: [CurrencyRate] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadFavoriteRates()
    }

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
    
    func loadFavoriteRates() {
        favoriteRates = CoreDataManager.shared.fetchRates()
    }
    
    func addToFavorites(_ rate: CurrencyRate) {
        if !favoriteRates.contains(where: { $0.identifier == rate.identifier }) {
            favoriteRates.append(rate)
            CoreDataManager.shared.saveFavoriteRate(rate)
        }
    }
    
    func removeFromFavorites(_ rate: CurrencyRate) {
        favoriteRates.removeAll { $0.identifier == rate.identifier }
        CoreDataManager.shared.removeFavoriteRate(rate)
    }
}
