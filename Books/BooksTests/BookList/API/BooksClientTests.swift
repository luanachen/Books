//
//  BooksClientTests.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 01/03/24.
//

import XCTest
import Combine
@testable import Books

class BooksClientTests: XCTestCase {

    // MARK: - Live Implementation Tests

    func testLive_GetBookList_Success() {
        let mockGetBookListResponse = Books(books: [Book.mock(), Book.mock()], success: true)
        let mockNetworkManager = MockNetworkManager(isSuccessCall: true, mockedResponse: mockGetBookListResponse)
        let client = BooksClient.live(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "Get book list successful")

    
        let cancellable = client.getBookList()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { books in
                    XCTAssertEqual(books.count, 2)
                    expectation.fulfill()
                  })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
    
    func testLive_GetBookDetail_Success() {
        let mockGetBookDetailResponse = BookDetail(success: true, payload: BookDetail.Payload.mock())
        let mockNetworkManager = MockNetworkManager(isSuccessCall: true, mockedResponse: mockGetBookDetailResponse)
        let client = BooksClient.live(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "Get book detail successful")
        
        let cancellable = client.getBookDetail(book: "btc_mxn")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { bookDetail in
                    XCTAssertEqual(bookDetail.name, "btc_mxn")
                    expectation.fulfill()
                  })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }

    // MARK: - Mock Implementation Tests

    func testMock_GetBookList_Success() {
        let expectation = self.expectation(description: "Get book list successful")
        let client = BooksClient.mock(stubbedBooks: [Book.mock(), Book.mock(name: "eth_mxn")])
        
        let cancellable = client.getBookList()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { books in
                    XCTAssertEqual(books.count, 2)
                    expectation.fulfill()
                  })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
    
    func testMock_GetBookDetail_Success() {
        let expectation = self.expectation(description: "Get book detail successful")
        let client = BooksClient.mock(stubbedBookDetail: BookDetail.Payload.mock())
        
        let cancellable = client.getBookDetail(book: "btc_mxn")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { bookDetail in
                    XCTAssertEqual(bookDetail.name, "btc_mxn")
                    expectation.fulfill()
                  })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
    
    func testMock_GetBookList_Failure() {
        let expectation = self.expectation(description: "Get book list failure")
        let client = BooksClient.mockFailure()
        
        let cancellable = client.getBookList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                case .finished:
                    break
                }
            },
            receiveValue: { _ in })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
    
    func testMock_GetBookDetail_Failure() {
        let expectation = self.expectation(description: "Get book detail failure")
        let client = BooksClient.mockFailure()
        
        let cancellable = client.getBookDetail(book: "btc_mxn")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                case .finished:
                    break
                }
            },
            receiveValue: { _ in })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
}

import BooksNetworking

final class MockNetworkManager<Response>: RESTNetworkingProtocol {
    var isSuccessCall = false
    var mockedResponse: Response
    
    init(isSuccessCall: Bool = false, mockedResponse: Response) {
        self.isSuccessCall = isSuccessCall
        self.mockedResponse = mockedResponse
    }
    
    func request<T: Decodable>(request: APIRequestConfiguration, completion: @escaping (Result<T, Error>) -> Void) {
        if isSuccessCall {
            completion(.success(mockedResponse as! T))
        } else {
            let error = NSError(domain: "MockNetworkManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mock failure"])
            completion(.failure(error))
        }
    }
}
