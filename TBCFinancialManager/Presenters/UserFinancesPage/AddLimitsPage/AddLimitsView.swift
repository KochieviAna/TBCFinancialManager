//
//  AddLimitsView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct AddLimitsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var limitAmount: String = ""
    @State private var selectedExpense: ExpenseTypeModel?
    @State private var isPickerPresented: Bool = false
    @State private var expenses: [ExpenseTypeModel] = []
    @State private var showDuplicateAlert: Bool = false
    
    let onLimitAdded: (ExpenseTypeModel) -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                limitDetailView
                selectExpenseTypeView
                Spacer(minLength: 300)
                setLimitButton
            }
            .navigationTitle("Set Expense Limit")
            .background(Color("backgroundColor"))
            .alert(isPresented: $showDuplicateAlert) {
                Alert(title: Text("Duplicate Expense"), message: Text("This expense type already has a limit set. Please choose another expense type."), dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            expensePickerSheet
        }
    }
    
    private var limitDetailView: some View {
        VStack {
            HStack {
                Text("Limit Amount")
                    .font(.popinsRegular(size: 12))
                    .foregroundColor(.primaryBlue)
                
                Spacer()
            }
            
            TextField("", text: $limitAmount)
                .keyboardType(.decimalPad)
                .frame(height: 30)
                .font(.popinsLight(size: 12))
                .foregroundStyle(.primaryBlack)
            
            Divider()
                .foregroundColor(.primaryBlue)
        }
        .padding()
    }
    
    private var selectExpenseTypeView: some View {
        VStack {
            HStack {
                Text("Expense Type")
                    .font(.popinsRegular(size: 12))
                    .foregroundColor(.primaryBlue)
                
                Spacer()
            }
            
            HStack {
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    Text(selectedExpense?.name ?? "Select Expense")
                        .font(.popinsLight(size: 12))
                        .foregroundColor(selectedExpense == nil ? .primaryBlack : .primaryWhite)
                }
                
                Spacer()
            }
            .padding(.top)
            
            Divider()
                .foregroundColor(.primaryBlue)
        }
        .padding()
    }
    
    private var expensePickerSheet: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Done") {
                    isPickerPresented = false
                }
                .foregroundColor(.primaryBlue)
            }
            
            Picker("Expense Type", selection: $selectedExpense) {
                ForEach(expenses, id: \.id) { expense in
                    Text(expense.name).tag(expense as ExpenseTypeModel?)
                }
            }
            .pickerStyle(.wheel)
        }
        .presentationDetents([.height(300), .medium])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
    }
    
    private var setLimitButton: some View {
        Button(action: {
            guard let selectedExpense = selectedExpense, let limit = Double(limitAmount) else { return }
            
            if selectedExpense.limit > 0 {
                showDuplicateAlert = true
                return
            }
            
            var newExpense = selectedExpense
            newExpense.limit = limit
            
            onLimitAdded(newExpense)
            dismiss()
        }) {
            Text("Set Limit")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryBlue)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
        .padding()
        .disabled(selectedExpense?.limit ?? 0 > 0)
    }
}


#Preview {
    AddLimitsView(onLimitAdded: {_ in })
}
