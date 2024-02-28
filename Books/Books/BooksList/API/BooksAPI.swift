//
//  BooksAPI.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 28/02/24.
//

import Foundation

enum BooksAPI {
    case getBooksList
}

extension BooksAPI: APIRequestConfiguration {
    
    var path: String {
        switch self {
        case .getBooksList:
            return "/v3/available_books/"
        }
    }
    
    var method: APIRequestHTTPMethod {
        switch self {
        case .getBooksList:
            return .get
        }
    }
    
    var parameters: APIRequestParameters? {
        switch self {
        case .getBooksList:
            return nil
        }
    }
    
    var headers: APIRequestHeaders? {
        switch self {
        case .getBooksList:
            return nil
        }
    }
}
