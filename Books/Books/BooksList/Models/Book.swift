//
//  Book.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import Foundation

struct Books: Codable {
    let books: [Book]
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case books = "payload"
        case success
    }
}

struct Book: Codable, Identifiable {
    let id = UUID()
    let defaultChart: DefaultChart
    let minimumPrice: String
    let maximumPrice: String
    let name: String
    let minimumValue: String
    let maximumAmount: String
    let maximumValue: String
    let minimumAmount: String
    let tickSize: String
    let locale: Locale = Locale.current
    
    enum CodingKeys: String, CodingKey {
        case defaultChart = "default_chart"
        case minimumPrice = "minimum_price"
        case maximumPrice = "maximum_price"
        case name = "book"
        case minimumValue = "minimum_value"
        case maximumAmount = "maximum_amount"
        case maximumValue = "maximum_value"
        case minimumAmount = "minimum_amount"
        case tickSize = "tick_size"
    }
}

extension Book {
    
    enum DefaultChart: String, Codable {
        case candle = "candle"
        case depth = "depth"
        case tradingview = "tradingview"
    }
    
    struct FlatRate: Codable {
        let maker: String
        let taker: String
    }
    
    struct Structure: Codable {
        let volume: String
        let maker: String
        let taker: String
    }
}

// MARK: - Helpers

extension Book {
    var displayedName: String {
        name.replacingOccurrences(of: "_", with: " ").uppercased()
    }
    
    var formattedMaximumPrice: String {
        maximumPrice.formattedPrice()
    }
    
    var formattedPriceRange: String {
        let minFormatted = minimumPrice.formattedPrice()
        let maxFormatted = maximumPrice.formattedPrice()
        return "\(minFormatted) - \(maxFormatted)"
    }
}

#if DEBUG

extension Book {
    static func mock(name: String = "btc_mxn") -> Self {
        Book(defaultChart: .tradingview, minimumPrice: "20000", maximumPrice: "7000000", name: name, minimumValue: "10.00", maximumAmount: "600", maximumValue: "200000000", minimumAmount: "0.00000060000", tickSize: "10")
    }
}

#endif
