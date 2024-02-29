//
//  ContentView.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import SwiftUI

struct BooksListView: View {

    @ObservedObject var viewModel = BooksListViewModel()
    @State private var showErrorToast = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.books, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(viewModel: .init(book: book.name))) {
                        itemView(book: book)
                    }
                }
            }
            .id("book_list_view")
            .navigationBarTitle("Books")
            .refreshable {
                await fetchData()
            }
        }
        .onAppear {
            Task {
                await fetchData()
            }
        }
        .alert(isPresented: $showErrorToast) {
            Alert(title: Text("Error"),
                  message: Text("Failed to fetch book list"),
                  primaryButton: .default(Text("Try Again")) {
                Task {
                    await fetchData()
                }
            }, secondaryButton: .cancel())
        }
        .onReceive(viewModel.$error) { error in
            showErrorToast = error != nil
        }
    }
}

private extension BooksListView {
    func itemView(book: Book) -> some View {
        VStack(alignment: .leading) {
            Text(book.displayedName)
                .font(.headline)
                .id("book_name_item_view")
            
            Text("Maximum Price: \(book.formattedMaximumPrice)")
                .foregroundColor(Color.blue)
                .id("maximum_price_item_view")
            
            Text("Price Range: \(book.formattedPriceRange)")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .id("price_range_item_view")
        }
        .id("book_item_row_\(book.name)")
    }
    
    func fetchData() async {
        await viewModel.fetchData()
    }
}

#if DEBUG

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BooksListViewModel(env: .init(client: .mock()))
        return BooksListView(viewModel: viewModel)
    }
}

#endif
