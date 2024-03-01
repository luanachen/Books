//
//  BookListViewModel.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import XCTest
@testable import Books

final class BooksListViewModelTests: XCTestCase {
    var sut: BooksListViewModel!
    
    override func setUp() {
        sut = BooksListViewModel(env: .init(client: .mock()))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchData() async {
        let expectedBooks = [Book.mock(), Book.mock(name: "eth_mxn")]
        let expectation = XCTestExpectation(description: "Fetch data")
        Task {
            await sut.fetchData()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(sut.books, expectedBooks)
    }
}
