//
//  BookDetailView.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import SwiftUI

struct BookDetailView: View {
    
    @ObservedObject var viewModel: BookDetailViewModel
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
           VStack(alignment: .leading, spacing: 20) {
               bookDetailSection
               
               Divider()
               
               tradingInfoSection
               
               Spacer()
           }
           .padding()
           .navigationBarTitle(viewModel.displayedName)
           .onAppear {
               Task {
                   await fetchBookDetail()
               }
           }
       }
}

extension BookDetailView {
    var bookDetailSection: some View {
        Section(header: Text("Book Details").font(.headline)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Volume: \(viewModel.formattedVolume)").id("volume_item_view")
                Text("High: \(viewModel.formattedHigh)").id("high_item_view")
                Text("Change 24h: \(viewModel.formattedChange24)").id("change24_item_view")
            }
        }
        .id("book_detail_section_view")
    }
    
    var tradingInfoSection: some View {
        Section(header: Text("Trading Information").font(.headline)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ask: \(viewModel.formattedAsk)").id("ask_item_view")
                Text("Bid: \(viewModel.formattedBid)").id("bid_item_view")
            }
        }
        .id("book_detail_trading_view")
    }
}

extension BookDetailView {
    
    func fetchBookDetail() async {
        do {
            try await viewModel.fetchBookDetail()
        } catch {
            // TODO: Handle error
            print("Error: \(error)")
        }
    }
}

#if DEBUG

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BookDetailViewModel(book: "XYZ", env: .init(client: .mock()))
        return BookDetailView(viewModel: viewModel)
    }
}

#endif
