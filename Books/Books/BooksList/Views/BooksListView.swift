//
//  ContentView.swift
//  Books
//
//  Created by Luana Chen on 27/02/24.
//

import SwiftUI

struct BooksListView: View {

    @ObservedObject var viewModel = BooksListViewModel()
    @State var showErrorToast = false
    @State private var timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var didShowError: ((Self) -> Void)?
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.books, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(viewModel: .init(book: book.name))) {
                        itemView(book: book)
                    }
                    .onDisappear {
                        timer.upstream.connect().cancel()
                    }
                }
            }
            .modifier(ListBackgroundModifier())
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
            alertView
        }
        .onReceive(viewModel.$error) { error in
            if error != nil {
                showErrorToast = true
                didShowError?(self)
            }
        }
        .onReceive(timer) { _ in
            Task {
                await fetchData()
            }
        }
    }
}

// MARK: Methods

private extension BooksListView {
    func fetchData() async {
        await viewModel.fetchData()
    }
}

// MARK: SubViews

private extension BooksListView {
    func itemView(book: Book) -> some View {
        VStack(alignment: .leading) {
            Text(book.displayedName)
                .font(.headline)
                .foregroundColor(Color.green)
                .id("book_name_item_view")
            
            Text("Maximum Price: \(book.formattedMaximumPrice)")
                .id("maximum_price_item_view")
            
            Text("Price Range: \(book.formattedPriceRange)")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .id("price_range_item_view")
        }
        .id("book_item_row_\(book.name)")
    }
    
    var alertView: Alert {
        Alert(title: Text("Error"),
              message: Text("Failed to fetch book list"),
              primaryButton: .default(Text("Try Again")) {
            Task {
                await fetchData()
            }
        }, secondaryButton: .cancel())
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
