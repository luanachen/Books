//
//  NetworkManagerTests.swift
//  BooksTests
//
//  Created by Luana Chen on 28/02/24.
//

import XCTest
@testable import BooksNetworking

class NetworkManagerTests: XCTestCase {

    func testRequest_Successful() {
        let jsonData = "{\"message\": \"Success response\"}".data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "https://books.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let manager = NetworkManager(session: MockNetworkSession(data: jsonData, response: response, error: nil))
        let requestConfig = MockRequestConfiguration()
        
        let expectation = XCTestExpectation(description: "Completion is called")
        manager.request(request: requestConfig) { (result: Result<MockResponseModel, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.message, "Success response")
            case .failure:
                XCTFail("Request should not fail")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRequest_NoData() {
        let manager = NetworkManager(session: MockNetworkSession(data: nil, response: nil, error: NetworkError.invalidURL))
        let requestConfig = MockRequestConfiguration()
        
        let expectation = XCTestExpectation(description: "Completion is called")
        manager.request(request: requestConfig) { (result: Result<MockResponseModel, Error>) in
            switch result {
            case .success:
                XCTFail("Request should fail for invalid URL")
            case .failure(let error):
                XCTAssertEqual((error as? NetworkError), NetworkError.invalidURL)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

// MARK: MockNetworkSession

private extension NetworkManagerTests {
    class MockNetworkSession: NetworkSession {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        func dataTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            completionHandler(data, response, error)
            return MockURLSessionDataTask()
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        override init() {}
        
        override func resume() {}
    }
}

// MARK: MockRequestConfiguration

private extension NetworkManagerTests {
    struct MockRequestConfiguration: APIRequestConfiguration {
        var method: APIRequestHTTPMethod
        var path: String
        var parameters: APIRequestParameters?
        var headers: APIRequestHeaders?
        
        init(method: APIRequestHTTPMethod = .get, path: String = "/path", parameters: APIRequestParameters? = nil, headers: APIRequestHeaders? = nil) {
            self.method = method
            self.path = path
            self.parameters = parameters
            self.headers = headers
        }
    }
}

// MARK: SampleResponseModel

private extension NetworkManagerTests {
    struct MockResponseModel: Codable {
        let message: String
    }
}
