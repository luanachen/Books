//
//  NetworkSession.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

public protocol NetworkSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
}

extension URLSession: NetworkSession {
    public func dataTask(request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
