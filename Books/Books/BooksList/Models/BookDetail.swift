//
//  BookDetail.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 28/02/24.
//

import Foundation

struct BookDetail: Codable {
    let success: Bool
    let payload: Payload
}

extension BookDetail {
    
    struct Payload: Codable {
        let high, last: String
        let createdAt: String
        let name, volume, vwap, low: String
        let ask, bid, change24: String
        let rollingAverageChange: RollingAverageChange

        enum CodingKeys: String, CodingKey {
            case high, last
            case createdAt = "created_at"
            case name = "book"
            case volume, vwap, low, ask, bid
            case change24 = "change_24"
            case rollingAverageChange = "rolling_average_change"
        }
    }
    
    struct RollingAverageChange: Codable {
        let the6: String

        enum CodingKeys: String, CodingKey {
            case the6 = "6"
        }
    }
}

extension BookDetail.Payload {
    var displayedName: String {
        name.replacingOccurrences(of: "_", with: " ").uppercased()
    }
    
    var formattedVolume: String {
        volume.formattedAmount()
    }
    
    var formattedHigh: String {
        high.formattedPrice()
    }
    
    var formattedChange24: String {
        change24.formattedPrice()
    }
    
    var formattedAsk: String {
        ask.formattedPrice()
    }
    
    var formattedBid: String {
        bid.formattedPrice()
    }
}

#if DEBUG

extension BookDetail.Payload {
    static func mock(name: String = "btc_mxn") -> Self {
        BookDetail.Payload(high: "1099390", last: "1049250", createdAt: "2024-02-28T22:58:39+00:00", name: name, volume: "151.49825997", vwap: "1027596.4059699391", low: "969100", ask: "1049020", bid: "1047600", change24: "18560", rollingAverageChange: .init(the6: "-0.0947"))
    }
}

#endif



