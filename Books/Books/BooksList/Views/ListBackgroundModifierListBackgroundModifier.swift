//
//  ListBackgroundModifierListBackgroundModifier.swift
//  Books
//
//  Created by Luana Chen (Contractor) on 01/03/24.
//

import SwiftUI

struct ListBackgroundModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
