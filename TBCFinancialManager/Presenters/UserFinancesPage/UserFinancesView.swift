//
//  UserFinancesView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct UserFinancesView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                }
            }
            .navigationTitle("My Finances")
        }
    }
}

#Preview {
    UserFinancesView()
}
