//
//  APIRequestParameters.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias APIRequestParameters = [String: Any]

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias APIRequestHeaders = [String: String]

public enum APIRequestHTTPMethod: Equatable {
    case get
    case patch
    case post
    case put
}
