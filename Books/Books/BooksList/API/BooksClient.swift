//
//  BooksClient.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 28/02/24.
//

import Combine

struct BooksClient {
    private let _getBookList: () -> AnyPublisher<[Book], Error>
    private let _getBookDetail: (String) -> AnyPublisher<BookDetail.Payload, Error>
    
    private init(
        getBookList: @escaping () -> AnyPublisher<[Book], Error>,
        getBookDetail: @escaping (String) -> AnyPublisher<BookDetail.Payload, Error>
    ) {
        self._getBookList = getBookList
        self._getBookDetail = getBookDetail
    }
    
    func getBookList() -> AnyPublisher<[Book], Error> {
        _getBookList()
    }
    
    func getBookDetail(book: String) -> AnyPublisher<BookDetail.Payload, Error> {
        _getBookDetail(book)
    }
}

// MARK: Live implementation

extension BooksClient {
    static func live(networkManager: RESTNetworkingProtocol = NetworkManager()) -> Self {
        BooksClient(
            getBookList: {
                return Future<[Book], Error> { promise in
                    networkManager.request(request: BooksAPI.getBooksList) { (result: Result<Books, Error>) in
                        switch result {
                        case .success(let result):
                            promise(.success(result.books))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
                }.eraseToAnyPublisher()
            },
            getBookDetail: { book in
                return Future<BookDetail.Payload, Error> { promise in
                    networkManager.request(request: BooksAPI.getBookDetail(book)) { (result: Result<BookDetail, Error>) in
                        switch result {
                        case .success(let result):
                            promise(.success(result.payload))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
                }.eraseToAnyPublisher()
            }
        )
    }
}

// MARK: Mock implementation

#if DEBUG
extension BooksClient {
    enum MockError: Error {
        case genericError
    }
    
    static func mock(stubbedBooks: [Book]? = nil, stubbedBookDetail: BookDetail.Payload? = nil) -> Self {
        BooksClient(
            getBookList: {
                let books = stubbedBooks ?? [Book.mock(), Book.mock(name: "eth_mxn")]
                return Future<[Book], Error> { promise in
                    promise(.success(books))
                }.eraseToAnyPublisher()
            },
            getBookDetail: { _ in
                let bookDetail = stubbedBookDetail ?? BookDetail.Payload.mock()
                return Future<BookDetail.Payload, Error> { promise in
                    promise(.success(bookDetail))
                }.eraseToAnyPublisher()
            }
        )
    }
    
    static func mockFailure() -> Self {
        BooksClient(
            getBookList: {
                return Future<[Book], Error> { promise in
                    promise(.failure(MockError.genericError))
                }.eraseToAnyPublisher()
            },
            getBookDetail: { _ in
                return Future<BookDetail.Payload, Error> { promise in
                    promise(.failure(MockError.genericError))
                }.eraseToAnyPublisher()
            }
        )
    }
}
#endif
