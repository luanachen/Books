//
//  BookDetailViewModel.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 28/02/24.
//

import Combine
import Foundation

class BookDetailViewModel: ObservableObject {
    
    struct Environment {
        var client: BooksClient = .live()
    }
    
    @Published var bookDetail: BookDetail.Payload?
    
    private let book: String
    private let env: Environment
    private var cancellables = Set<AnyCancellable>()
    
    init(book: String, env: Environment = .init()) {
        self.book = book
        self.env = env
    }
    
    func fetchBookDetail() async throws {
        env.client.getBookDetail(book: book)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // TODO: finish loading
                    print("success")
                case .failure(let error):
                    // TODO: handle error
                    print("error")
                }
            }, receiveValue: { [weak self] bookDetail in
                self?.bookDetail = bookDetail
            })
            .store(in: &cancellables)
    }
}