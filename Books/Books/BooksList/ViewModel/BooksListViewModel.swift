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
    @Published var error: Error?
    
    // For testing refresh behavior
    var count: Int = 0
    
    private let env: Environment
    private var cancellables = Set<AnyCancellable>()
    
    init(env: Environment = .init()) {
        self.env = env
    }
    
    func fetchData() async {
        env.client.getBookList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.count += 1
                    print("success fetch count: \(String(describing: self?.count))")
                case .failure(let error):
                    self?.error = error
                }
            }, receiveValue: { [weak self] books in
                self?.books = books
            })
            .store(in: &cancellables)
    }
}
