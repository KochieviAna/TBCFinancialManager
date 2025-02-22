//
//  UserFinancesView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct UserFinancesView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var isAddingLimit = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if networkManager.expenses.isEmpty {
                    EmptyView()
                } else {
                    ManagedView(expenses: networkManager.expenses)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Financial Manager")
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
                    networkManager.addExpense(newExpense)
                    networkManager.fetchExpenses()
                }
            }
            .onAppear {
                networkManager.fetchExpenses()
            }
        }
    }
}

#Preview {
    UserFinancesView()
}
