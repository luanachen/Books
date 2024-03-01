//
//  BooksAPI.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 28/02/24.
//

import BooksNetworking
import Foundation

enum BooksAPI {
    case getBooksList
    case getBookDetail(String)
}

extension BooksAPI: APIRequestConfiguration {
    
    var path: String {
        switch self {
        case .getBooksList:
            return "/v3/available_books/"
        case .getBookDetail:
            return "/v3/ticker/"
        }
    }
    
    var method: APIRequestHTTPMethod {
        switch self {
        case .getBooksList, .getBookDetail:
            return .get
        }
    }
    
    var parameters: APIRequestParameters? {
        switch self {
        case .getBooksList:
            return nil
        case let .getBookDetail(book):
            return ["book": book]
        }
    }
    
    var headers: APIRequestHeaders? {
        switch self {
        case .getBooksList, .getBookDetail:
            return nil
        }
    }
}
