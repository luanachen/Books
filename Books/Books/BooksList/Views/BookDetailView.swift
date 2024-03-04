//
//  BookDetailView.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 27/02/24.
//

import SwiftUI

struct BookDetailView: View {
    
    @ObservedObject var viewModel: BookDetailViewModel
    @State var showErrorToast = false
    
    var didShowError: ((Self) -> Void)?
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
           VStack(alignment: .leading, spacing: 20) {
               bookDetailSection
                              
               tradingInfoSection
               
               Spacer()
           }
           .navigationBarTitle(viewModel.displayedName)
           .onAppear {
               Task {
                   await fetchData()
               }
           }
           .alert(isPresented: $showErrorToast) {
              alert
           }
           .onReceive(viewModel.$error) { error in
               if error != nil {
                   showErrorToast = true
                   didShowError?(self)
               }
           }
       }
}

// MARK: Methods

private extension BookDetailView {
    
    func fetchData() async {
        await viewModel.fetchData()
    }
}

// MARK: Subviews

private extension BookDetailView {
    var bookDetailSection: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Book Details")
                    .font(.headline)
                    .font(.system(size: 36))
                    .padding()
                VStack(alignment: .leading, spacing: 16) {
                    itemView(iconName: "chart.bar.fill", title: "Volume", description: viewModel.formattedVolume)
                    Divider()
                    itemView(iconName: "chart.line.uptrend.xyaxis", title: "High", description: viewModel.formattedHigh)
                    Divider()
                    itemView(iconName: "clock", title: "Change 24h", description: viewModel.formattedChange24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Color.gray
                    .opacity(0.1)
                    .frame(maxWidth: .infinity, maxHeight: 8)
            }
        }
        .id("book_detail_section_view")
    }
    
    var tradingInfoSection: some View {
        VStack(alignment: .leading) {
            Text("Trading Information")
                .font(.headline)
                .font(.system(size: 24))
                .padding()
            VStack(alignment: .leading, spacing: 16) {
                itemView(iconName: "arrowshape.turn.up.backward.badge.clock", title: "Ask", description: viewModel.formattedAsk)
                Divider()
                itemView(iconName: "hammer.fill", title: "Bid", description: viewModel.formattedBid)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .id("book_detail_trading_view")
    }
    
    func itemView(iconName: String? = nil, title: String, description: String) -> some View {
        HStack(spacing: 16) {
            if let iconName = iconName {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(description)
                    .fontWeight(.regular)
                    .id("price_range_item_view")
            }
        }
    }
    
    var alert: Alert {
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

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BookDetailViewModel(book: "XYZ", env: .init(client: .mock()))
        return BookDetailView(viewModel: viewModel)
    }
}

#endif
