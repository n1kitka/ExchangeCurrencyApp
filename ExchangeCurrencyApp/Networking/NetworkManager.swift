//
//  NetworkManager.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://swop.cx/rest/rates"
    private let apiKey = "e5d79bb7c7e5ba34b931979e2b6cb59d7b8f2cbe9984968d50c1f650004b0896"

    func fetchRates() -> AnyPublisher<[CurrencyRate], Error> {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [URLQueryItem(name: "api-key", value: apiKey)]

        guard let url = components?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [CurrencyRate].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
