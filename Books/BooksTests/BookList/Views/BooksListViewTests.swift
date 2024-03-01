//
//  BooksTests.swift
//  BooksTests
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import ViewInspector
import XCTest
@testable import Books

final class BooksListViewTests: XCTestCase {
    var mockViewModel: BooksListViewModel!
    var sut: BooksListView!

    override func setUp() {
        let stubbedBooks = [Book.mock(), Book.mock(name: "eth_mxn")]
        mockViewModel = BooksListViewModel(env: .init(client: .mock(stubbedBooks: stubbedBooks)))
        sut = BooksListView(viewModel: mockViewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testHasPreview() {
        XCTAssertNotNil(BooksListView_Previews.previews)
    }

    func testViewHasCorrectSubViews() async throws {
        await mockViewModel.fetchData()
        
        let value = try? sut.inspect().find(viewWithId: "book_list_view")
        XCTAssertNotNil(value, "cannot be nil")
        
        let value1 = try? sut.inspect().find(viewWithId: "book_item_row_btc_mxn")
        XCTAssertNotNil(value1, "cannot be nil")
        
        let value2 = try? sut.inspect().find(viewWithId: "book_item_row_eth_mxn")
        XCTAssertNotNil(value2, "cannot be nil")
        
        let value3 = try? sut.inspect().find(viewWithId: "book_name_item_view")
        XCTAssertNotNil(value3, "cannot be nil")
        
        let value4 = try? sut.inspect().find(viewWithId: "maximum_price_item_view")
        XCTAssertNotNil(value4, "cannot be nil")
        
        let value5 = try? sut.inspect().find(viewWithId: "price_range_item_view")
        XCTAssertNotNil(value5, "cannot be nil")
    }
    
    func testShowAlertViewWhenAPICallFails() {
        mockViewModel = BooksListViewModel(env: .init(client: .mockFailure()))
        sut = BooksListView(viewModel: mockViewModel)
        
        let exp = sut.on(\.didShowError) { view in
            XCTAssertTrue(try view.actualView().showErrorToast)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1)
    }
}
