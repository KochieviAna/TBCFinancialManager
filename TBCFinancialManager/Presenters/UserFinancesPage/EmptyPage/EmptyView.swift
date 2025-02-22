//
//  EmptyView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {            
            emptyContent
        }
    }
    
    private var emptyContent: some View {
        VStack {
            Text("დაწესებული ლიმიტები ხელმისაწვდომი არა არის.")
                .font(.popinsSemiBold(size: 13))
                .foregroundColor(.primaryBlack)
            
            Text("დააჭირე '+' ღილაკს დანახარჯების მართვის დასაწყებად")
                .font(.popinsSemiBold(size: 12))
                .foregroundColor(.secondaryGrey)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyView()
}
