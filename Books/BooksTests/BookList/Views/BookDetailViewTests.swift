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
    var mockViewModel: BookDetailViewModel!
    var sut: BookDetailView!

    override func setUp() {
        mockViewModel = BookDetailViewModel(book: "Book", env: .init(client: .mock()))
        sut = BookDetailView(viewModel: mockViewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testHasPreview() {
        XCTAssertNotNil(BookDetailView_Previews.previews)
    }

    func testViewHasCorrectSubViews() async throws {
        await mockViewModel.fetchData()
        
        let value = try? sut.inspect().find(viewWithId: "book_detail_section_view")
        XCTAssertNotNil(value, "cannot be nil")
        
        let value1 = try? sut.inspect().find(viewWithId: "volume_item_view")
        XCTAssertNotNil(value1, "cannot be nil")
        
        let value2 = try? sut.inspect().find(viewWithId: "high_item_view")
        XCTAssertNotNil(value2, "cannot be nil")
        
        let value3 = try? sut.inspect().find(viewWithId: "change24_item_view")
        XCTAssertNotNil(value3, "cannot be nil")
        
        let value4 = try? sut.inspect().find(viewWithId: "ask_item_view")
        XCTAssertNotNil(value4, "cannot be nil")
        
        let value5 = try? sut.inspect().find(viewWithId: "bid_item_view")
        XCTAssertNotNil(value5, "cannot be nil")
    }
    
    func testShowAlertViewWhenAPICallFails() {
        mockViewModel = BookDetailViewModel(book: "Book", env: .init(client: .mockFailure()))
        sut = BookDetailView(viewModel: mockViewModel)
        
        let exp = sut.on(\.didShowError) { view in
            XCTAssertTrue(try view.actualView().showErrorToast)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }
}
