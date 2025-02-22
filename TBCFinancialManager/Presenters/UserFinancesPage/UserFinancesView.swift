//
//  UserFinancesView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct UserFinancesView: View {
    @State private var isAddingLimit = false
    @State private var expenses: [ExpenseTypeModel] = []

    var body: some View {
        NavigationStack {
            VStack {
                if expenses.isEmpty {
                    EmptyView()
                } else {
                    Spacer(minLength: 150)
                    
                    ManagedView(expenses: expenses)
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("ფინანსური მენეჯერი")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddingLimit = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primaryBlue)
                    }
                }
            }
            .background(Color("backgroundColor"))
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $isAddingLimit) {
                AddLimitsView { newExpense in
                    expenses.append(newExpense)
                }
            }
        }
    }
}

#Preview {
    UserFinancesView()
}
