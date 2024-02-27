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

    override func setUpWithError() throws {
        sut = BooksListViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchBooks() throws {
        sut.fetchBooks()
        XCTAssertNotNil(sut.books)
    }

}
