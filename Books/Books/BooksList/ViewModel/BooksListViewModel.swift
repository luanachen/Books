//
//  BooksListViewModel.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Foundation

class BooksListViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        let mockBooks = [Book.mock(), Book.mock(name: "eth_mxn")]
        
        self.books = mockBooks
    }
}
