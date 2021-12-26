//
//  СurrencyData.swift
//  jsonCurrency
//
//  Created by Igor Abovyan on 01.12.2021.
// 

import Foundation


// MARK: - Data Json
struct DataJson: Codable {
    let name: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    var isFavorites: Bool?
}

