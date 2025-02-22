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
            Text("You don't have managed finances yet")
                .font(.popinsSemiBold(size: 16))
                .foregroundColor(.primaryBlack)
            
            Text("Click '+' button to start managing your finances")
                .font(.popinsSemiBold(size: 12))
                .foregroundColor(.secondaryGrey)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyView()
}
