//
//  ContentView.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import SwiftUI

struct BooksListView: View {
    @ObservedObject var viewModel = BooksListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    itemView(book: book)
                }
            }
            .id("book_list_view")
            .navigationBarTitle("Books")
            .refreshable {
                viewModel.fetchBooks()
            }
        }
        .onAppear {
            viewModel.fetchBooks()
        }
    }
}

extension BooksListView {
    func itemView(book: Book) -> some View {
        VStack(alignment: .leading) {
            Text(book.displayedName)
                .font(.headline)
            
            Text("Maximum Price: \(book.formattedMaximumPrice)")
                .foregroundColor(Color.blue)
            
            Text("Price Range: \(book.formattedPriceRange)")
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
        .id("book_item_row_\(book.name)")
    }
}

#if DEBUG

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BooksListViewModel()
        return BooksListView(viewModel: viewModel)
    }
}

#endif
