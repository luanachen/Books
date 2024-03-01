//
//  BooksAPITests.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 01/03/24.
//

import XCTest
@testable import Books

final class BooksAPITests: XCTestCase {
    
    // MARK: getBooksList

    func testGetBooksListPath() {
        XCTAssertEqual(BooksAPI.getBooksList.path, "/v3/available_books/")
    }
    
    func testGetBooksListMethod() {
        XCTAssertEqual(BooksAPI.getBooksList.method, .get)
    }
    
    func testGetBooksListParameters() {
        XCTAssertNil(BooksAPI.getBooksList.parameters)
    }
    
    func testGetBooksListHeaders() {
        XCTAssertNil(BooksAPI.getBooksList.headers)
    }
    
    // MARK: getBookDetail

    func testGetBookDetailPath() {
        XCTAssertEqual(BooksAPI.getBookDetail("bookID").path, "/v3/ticker/")
    }

    func testGetBookDetailMethod() {
        XCTAssertEqual(BooksAPI.getBookDetail("bookID").method, .get)
    }

    func testGetBookDetailParameters() {
        XCTAssertEqual(BooksAPI.getBookDetail("bookID").parameters as? [String: String], ["book": "bookID"])
    }

    func testGetBookDetailHeaders() {
        XCTAssertNil(BooksAPI.getBookDetail("bookID").headers)
    }
}
