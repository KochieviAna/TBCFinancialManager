//
//  ManagedView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct ManagedView: View {
    @State private var thisYearElectricity: Double = 80
    @State private var lastYearElectricity: Double = 60
    @State private var thisYearGas: Double = 50
    @State private var lastYearGas: Double = 30
    @State private var isEditing: Bool = false
    @State private var expenses: [ExpenseTypeModel]
    @State private var selectedExpenses: Set<UUID> = []
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    init(expenses: [ExpenseTypeModel]) {
        self._expenses = State(initialValue: expenses)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                assetsView
                
                managedExpensesHeadline
                
                ForEach(expenses, id: \.id) { expense in
                    limitedExpensesView(for: expense)
                }
                
                if isEditing && !selectedExpenses.isEmpty {
                    Button(action: deleteSelectedExpenses) {
                        Text("წაშლა")
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
                
                comparingResources
            }
            .background(Color("backgroundColor"))
        }
        .background(Color("backgroundColor"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var assetsView: some View {
        VStack {
            Divider()
            
            HStack {
                Text("ვალდებულებები")
                    .font(.popinsRegular(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("აქტივები")
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
                
                Text("500 GEL")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
            }
            .padding(.horizontal)
            
            Rectangle()
                .foregroundStyle(.primaryGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 2)
            
            HStack {
                Text("მდგომარეობა")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("500 GEL")
                    .font(.popinsLight(size: 16))
                    .foregroundStyle(.primaryLightGreen)
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
    
    private var managedExpensesHeadline: some View {
        HStack {
            Text("მიმდინარე თვე")
                .font(.popinsSemiBold(size: 18))
            
            Spacer()
            
            Button("შეცვლა") {
                isEditing.toggle()
            }
            .foregroundColor(.primaryBlue)
        }
        .padding()
    }
    
    private func limitedExpensesView(for expense: ExpenseTypeModel) -> some View {
        HStack {
            if isEditing {
                Button(action: {
                    toggleSelection(for: expense)
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
                    
                    Text("ლიმიტი: \(expense.formattedLimit) GEL")
                        .font(.popinsLight(size: 12))
                        .foregroundStyle(.primaryBlack)
                }
                
                ProgressView(value: expense.spent / max(expense.limit, expense.spent)) {}
                    .progressViewStyle(LinearProgressViewStyle())
                    .accentColor(getProgressColor(for: expense))
                
                HStack {
                    if expense.spent > expense.limit {
                        Text("დანახარჯი: \(expense.formattedSpent) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.primaryBlack)
                        
                        Spacer()
                        
                        Text("გადახარჯვა: \(expense.formattedExceeded) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.darkPink)
                    } else {
                        Text("დანახარჯი: \(expense.formattedSpent) GEL")
                            .font(.popinsLight(size: 12))
                            .foregroundStyle(.primaryBlack)
                        
                        Spacer()
                        
                        Text("მიმდინარე ბალანსი: \(expense.formattedRemainingBalance) GEL")
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
                
                Text("მწვანე ქულები")
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
            Text("გაუფრთხილდი ბუნებრივ რესურსებს")
                .font(.popinsSemiBold(size: 18))
                .foregroundStyle(.primaryBlack)
            
            Spacer()
        }
        .padding()
    }
    
    private var comparingResources: some View {
        VStack() {
            HStack {
                Text("ელექტროენერგია")
                    .font(.popinsRegular(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
            }
            .padding(.leading)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("მიმდინარე წელი")
                        .font(.popinsLight(size: 14))
                        .foregroundStyle(.primaryBlack)
                    
                    ProgressView(value: thisYearElectricity, total: max(lastYearElectricity, thisYearElectricity))
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.darkPink)
                }
                
                VStack(alignment: .leading) {
                    Text("წინა წელი")
                        .font(.popinsLight(size: 14))
                        .foregroundStyle(.primaryBlack)
                    
                    ProgressView(value: lastYearElectricity, total: max(lastYearElectricity, thisYearElectricity))
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.darkGreen)
                }
            }
            .padding()
            
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("ბუნებრივი აირი")
                    .font(.popinsRegular(size: 16))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
            }
            .padding(.leading)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("მიმდინარე წელი")
                        .font(.popinsLight(size: 14))
                        .foregroundStyle(.primaryBlack)
                    
                    ProgressView(value: thisYearGas, total: max(lastYearGas, thisYearGas))
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.darkPink)
                }
                
                VStack(alignment: .leading) {
                    Text("წინა წელი")
                        .font(.popinsLight(size: 14))
                        .foregroundStyle(.primaryBlack)

                    
                    ProgressView(value: lastYearGas, total: max(lastYearGas, thisYearGas))
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.darkGreen)
                }
            }
            .padding()
        }
    }
    
    private func deleteSelectedExpenses() {
        expenses.removeAll { expense in
            selectedExpenses.contains(expense.id)
        }
        selectedExpenses.removeAll()
    }
    
    private func toggleSelection(for expense: ExpenseTypeModel) {
        if selectedExpenses.contains(expense.id) {
            selectedExpenses.remove(expense.id)
        } else {
            selectedExpenses.insert(expense.id)
        }
    }
    
    private func getProgressColor(for expense: ExpenseTypeModel) -> Color {
        if expense.spent > expense.limit {
            alertMessage = "Your expense has exceeded the limit by \(expense.formattedExceeded) GEL!"
            showAlert = true
            return .darkPink
        } else if expense.spent / expense.limit >= 0.8 {
            alertMessage = "Warning: You've spent over 80% of the limit!"
            showAlert = true
            return .darkOrange
        } else {
            return .green
        }
    }
}

#Preview {
    ManagedView(expenses: [
        ExpenseTypeModel(id: UUID(), name: "Groceries", limit: 100, spent: 80),
        ExpenseTypeModel(id: UUID(), name: "Transport", limit: 100, spent: 110)
    ])
}
