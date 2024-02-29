//
//  String+Extensions.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 29/02/24.
//

import Foundation

extension String {
    func formattedPrice() -> Self {
        guard let priceDouble = Double(self) else { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: priceDouble)) ?? ""
    }
    
    func formattedAmount() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: Double(self) ?? 0)) ?? ""
    }
}
