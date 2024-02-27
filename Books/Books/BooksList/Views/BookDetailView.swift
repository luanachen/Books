//
//  BookDetailView.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Book: \(book.displayedName)")
                .font(.headline)
                .padding()
            
            Text("Maximum Price: \(book.formattedMaximumPrice)")
                .padding()
            
            Text("Price Range: \(book.formattedPriceRange)")
                .padding()
        }
        .id("book_detail_view")
        .navigationBarTitle("\(book.displayedName)")
    }
}

#if DEBUG

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return BookDetailView(book: Book.mock())
    }
}

#endif
