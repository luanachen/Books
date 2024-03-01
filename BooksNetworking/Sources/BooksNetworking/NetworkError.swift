//
//  NetworkError.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
