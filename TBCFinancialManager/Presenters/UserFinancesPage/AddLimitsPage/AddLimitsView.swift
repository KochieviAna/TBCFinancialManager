//
//  AddLimitsView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct AddLimitsView: View {
    @FocusState private var isTextFieldFocused: Bool
    @State private var limitAmount: String = ""
    
    @State private var selectedExpense: String? = nil
    @State private var isPickerPresented: Bool = false
    
    @State private var expenses: [ExpenseTypeModel] = [
        ExpenseTypeModel(name: "Family & Household", darkColor: .darkOrange, lightColor: .lightOrange),
        ExpenseTypeModel(name: "Restaurant, Cafe, Bar", darkColor: .darkPink, lightColor: .lightPink),
        ExpenseTypeModel(name: "Travel & Leisure", darkColor: .darkBlue, lightColor: .lightBlue),
        ExpenseTypeModel(name: "Utility & Other Payments", darkColor: .darkYellow, lightColor: .lightYellow),
        ExpenseTypeModel(name: "Entertainment", darkColor: .darkGreen, lightColor: .lightGreen),
        ExpenseTypeModel(name: "Transportation", darkColor: .darkViolet, lightColor: .lightViolet),
        ExpenseTypeModel(name: "Health & Beauty", darkColor: .darkPurple, lightColor: .lightPurple),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                limitDetailView
                selectExpenseTypeView
                
                Spacer(minLength: 300)
                
                setLimitButton
            }
            .navigationTitle("Financial Manager")
            .background(Color("backgroundColor"))
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
                .focused($isTextFieldFocused)
                .background(Color.clear)
                .frame(height: 30)
                .font(.popinsLight(size: 12))
                .foregroundStyle(.primaryBlack)
                .onAppear {
                    isTextFieldFocused = true
                }
            
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
                    Text(selectedExpense ?? "Select Expense")
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
                .background(Color.clear)
                .foregroundColor(.primaryBlue)
            }
            
            Picker("Expense Type", selection: Binding(
                get: { selectedExpense ?? expenses.first?.name },
                set: { selectedExpense = $0 }
            )) {
                ForEach(expenses, id: \.name) { expense in
                    Text(expense.name).tag(expense.name as String?)
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
            
        }) {
            Text("Set Limit")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryBlue)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
        .padding()
    }
}

#Preview {
    AddLimitsView()
}
