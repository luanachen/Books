//
//  BookDetailViewTests.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import ViewInspector
import XCTest
@testable import Books

final class BookDetailViewTests: XCTestCase {
    var sut: BookDetailView!

    override func setUpWithError() throws {
        sut = BookDetailView(book: Book.mock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testHasPreview() {
        XCTAssertNotNil(BookDetailView_Previews.previews)
    }

    func testViewHasCorrectSubViews() throws {
        let value = try? sut.inspect().find(viewWithId: "book_detail_view")
        XCTAssertNotNil(value, "cannot be nil")
    }

}
