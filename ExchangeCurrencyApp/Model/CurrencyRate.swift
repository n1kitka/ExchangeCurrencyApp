//
//  CurrencyRate.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import Foundation

struct CurrencyRate: Codable {
    let baseCurrency: String
    let quoteCurrency: String
    let quote: Double
    let date: String

    enum CodingKeys: String, CodingKey {
        case baseCurrency = "base_currency"
        case quoteCurrency = "quote_currency"
        case quote
        case date
    }
}
