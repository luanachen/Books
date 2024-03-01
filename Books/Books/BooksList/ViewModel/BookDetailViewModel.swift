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
    @Published var error: Error?
    
    private let book: String
    private let env: Environment
    private var cancellables = Set<AnyCancellable>()
    
    init(book: String, env: Environment = .init()) {
        self.book = book
        self.env = env
    }
    
    func fetchData() async {
        env.client.getBookDetail(book: book)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // TODO: finish loading
                    print("success")
                case .failure(let error):
                    self?.error = error
                }
            }, receiveValue: { [weak self] bookDetail in
                self?.bookDetail = bookDetail
            })
            .store(in: &cancellables)
    }
    
    var displayedName: String {
        bookDetail?.displayedName ?? ""
    }
    
    var formattedVolume: String {
        bookDetail?.formattedVolume ?? ""
    }
    
    var formattedHigh: String {
        bookDetail?.formattedHigh ?? ""
    }
    
    var formattedChange24: String {
        bookDetail?.formattedChange24 ?? ""
    }
    
    var formattedAsk: String {
        bookDetail?.formattedAsk ?? ""
    }
    
    var formattedBid: String {
        bookDetail?.formattedBid ?? ""
    }
}
