//
//  RestNetworking.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

protocol RESTNetworkingProtocol {
    func request<T: Decodable>(request: APIRequestConfiguration, completion: @escaping (Result<T, Error>) -> Void)
}

public class NetworkManager: RESTNetworkingProtocol {
    var domainUrl: URL = URL(string: "https://api.bitso.com")!
    let session: NetworkSession
    
    public init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(request: APIRequestConfiguration, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = getUrl(path: request.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        
        session.dataTask(request: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    func getUrl(path: String) -> URL? {
        guard !path.isEmpty else { return domainUrl }
        return domainUrl.appendingPathComponent(path)
    }
}
