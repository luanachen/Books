//
//  APIRequestConfiguration.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

public protocol APIRequestConfiguration {
    var method: APIRequestHTTPMethod { get }
    var path: String { get }
    var parameters: APIRequestParameters? { get }
    var headers: APIRequestHeaders? { get }
}
