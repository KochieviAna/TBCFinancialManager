//
//  ManagedView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct ManagedView: View {
    @State private var isEditing: Bool = false
    @State private var expenses: [ExpenseTypeModel]
    @State private var selectedExpenses: Set<Int> = [] // Track selected expenses using Int as id
    
    // Custom initializer to make the view accessible
    init(expenses: [ExpenseTypeModel]) {
        self._expenses = State(initialValue: expenses)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                assetsView
                
                managedExpencesHeadline
                
                ForEach(expenses, id: \.id) { expense in
                    limitedExpensesView(for: expense)
                }
                                
                if isEditing && !selectedExpenses.isEmpty {
                    Button(action: deleteSelectedExpenses) {
                        Text("Delete")
                            .foregroundColor(.darkPink)
                            .font(.popinsRegular(size: 16))
                            .padding()
                            .background(Color.clear)
                    }
                    .padding()
                }
                
                Divider()
                
                greenPointsView
                
                Divider()

                naturalResourcesHeadline
            }
            .background(Color("backgroundColor"))
        }
        .background(Color("backgroundColor"))
    }
    
    private var assetsView: some View {
        VStack {
            Divider()
            
            HStack {
                Text("Liabilities")
                    .font(.popinsRegular(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("Assets")
                    .font(.popinsRegular(size: 16))
                    .foregroundStyle(.primaryBlack)
            }
            .padding(.top)
            .padding(.horizontal)
            
            HStack {
                Text("0 GEL")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("33 GEL")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
            }
            .padding(.horizontal)
            
            Rectangle()
                .foregroundStyle(.primaryGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 2)
            
            HStack {
                Text("Net Worth")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("33 GEL")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryLightGreen)
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
    
    private var managedExpencesHeadline: some View {
        HStack {
            Text("So far this month")
                .font(.popinsSemiBold(size: 18))
            
            Spacer()
            
            Button("Edit") {
                isEditing.toggle()  // Toggle edit mode when "Edit" is pressed
            }
            .foregroundColor(.primaryBlue)
        }
        .padding()
    }
    
    private func limitedExpensesView(for expense: ExpenseTypeModel) -> some View {
        HStack {
            if isEditing {
                Button(action: {
                    toggleSelection(for: expense)  // Toggle selection when button is pressed
                }) {
                    Image(systemName: selectedExpenses.contains(expense.id) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(selectedExpenses.contains(expense.id) ? .blue : .gray)
                }
                .padding(.leading, 8)
            }
                        
            VStack {
                HStack {
                    Text(expense.name)
                        .font(.popinsLight(size: 12))
                        .foregroundStyle(.primaryBlack)
                    
                    Spacer()
                    
                    Text("Limit: \(expense.formattedLimit) GEL")
                        .font(.popinsLight(size: 12))
                        .foregroundStyle(.primaryBlack)
                }
                
                // ProgressView with color changes based on the remaining balance or exceeded limit
                ProgressView(value: expense.spent / max(expense.limit, expense.spent)) {
                }
                .progressViewStyle(LinearProgressViewStyle())
                .accentColor(getProgressColor(for: expense))
                
                HStack {
                    if expense.spent > expense.limit {
                        Text("Spent: \(expense.formattedSpent) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.primaryBlack)
                        
                        Spacer()
                        
                        Text("Exceeded amount: \(expense.formattedExceeded) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.darkPink)
                    } else {
                        Text("Spent: \(expense.formattedSpent) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.primaryBlack)
                        
                        Spacer()
                        
                        Text("Remaining Balance: \(expense.formattedRemainingBalance) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.primaryBlack)
                    }
                }
            }
        }
        .padding()
    }
    
    private var greenPointsView: some View {
        HStack {
            Image("green")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                        
            VStack(alignment: .leading) {
                Text("2.67")
                    .font(.popinsSemiBold(size: 20))
                    .foregroundStyle(.primaryBlack)
                
                Text("Green Points")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
            }
            .padding(.leading)
            
            Spacer()
        }
        .padding()
    }
    
    private var naturalResourcesHeadline: some View {
        HStack {
            Text("Protect natural resources")
                .font(.popinsSemiBold(size: 18))
            
            Spacer()
        }
        .padding()
    }
    
    private func toggleSelection(for expense: ExpenseTypeModel) {
        if selectedExpenses.contains(expense.id) {
            selectedExpenses.remove(expense.id)  // Deselect if already selected
        } else {
            selectedExpenses.insert(expense.id)  // Select if not selected
        }
    }
    
    private func deleteSelectedExpenses() {
        expenses.removeAll { expense in
            selectedExpenses.contains(expense.id)  // Remove all selected expenses
        }
        selectedExpenses.removeAll()  // Clear the selection after deletion
    }
    
    private func getProgressColor(for expense: ExpenseTypeModel) -> Color {
        let remainingBalance = expense.remainingBalance
        if remainingBalance <= expense.limit * 0.1 && remainingBalance > 0 {
            return .darkOrange
        } else if expense.spent > expense.limit {
            return .darkPink
        } else {
            return .green
        }
    }
}

#Preview {
    ManagedView(expenses: [
        ExpenseTypeModel(id: 1, name: "Groceries", limit: 100, spent: 80),
        ExpenseTypeModel(id: 2, name: "Transport", limit: 100, spent: 110)
    ])
}
