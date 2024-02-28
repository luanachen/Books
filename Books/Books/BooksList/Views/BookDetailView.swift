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
               Section(header: Text("Book Details").font(.headline)) {
                   VStack(alignment: .leading, spacing: 8) {
                       Text("Volume: \(formattedAmount(viewModel.bookDetail?.volume ?? ""))")
                       Text("High: \(formattedCurrency(viewModel.bookDetail?.high ?? ""))")
                       Text("Change 24h: \(formattedCurrency(viewModel.bookDetail?.change24 ?? ""))")
                   }
               }
               
               Divider()
               
               Section(header: Text("Trading Information").font(.headline)) {
                   VStack(alignment: .leading, spacing: 8) {
                       Text("Ask: \(formattedCurrency(viewModel.bookDetail?.ask ?? ""))")
                       Text("Bid: \(formattedCurrency(viewModel.bookDetail?.bid ?? ""))")
                   }
               }
               
               Spacer()
           }
           .padding()
            // TODO: Add displayname, handle in viewModel
           .navigationBarTitle(viewModel.bookDetail?.book ?? "")
           .onAppear {
               Task {
                   await fetchBookDetail()
               }
           }
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
    
    func formattedAmount(_ amount: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: Double(amount) ?? 0)) ?? ""
    }
    
    func formattedCurrency(_ amount: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: Double(amount) ?? 0)) ?? ""
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
