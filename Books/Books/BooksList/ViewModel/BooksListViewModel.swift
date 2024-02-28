//
//  BooksListViewModel.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import Combine
import Foundation

class BooksListViewModel: ObservableObject {
    
    struct Environment {
        var client: BooksClient = .live()
    }
    
    @Published var books: [Book] = []
    
    private let env: Environment
    private var cancellables = Set<AnyCancellable>()
    
    init(env: Environment = .init()) {
        self.env = env
    }
    
    func fetchBooks() {
        env.client.getBookList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // TODO: finish loading
                    print("success")
                case .failure(let error):
                    // TODO: handle error
                    print("error")
                }
            }, receiveValue: { [weak self] books in
                self?.books = books
            })
            .store(in: &cancellables)
    }
}
