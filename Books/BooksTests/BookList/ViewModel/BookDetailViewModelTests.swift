//
//  BookDetailViewModelTests.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 29/02/24.
//

import XCTest
@testable import Books

final class BookDetailViewModelTests: XCTestCase {
    var sut: BookDetailViewModel!

    override func setUp() async throws {
        sut = BookDetailViewModel(book: "Book", env: .init(client: .mock()))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchData() async {
        let expectation = XCTestExpectation(description: "Fetch data")
        Task {
            await sut.fetchData()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertNotNil(sut.bookDetail)
    }
}
