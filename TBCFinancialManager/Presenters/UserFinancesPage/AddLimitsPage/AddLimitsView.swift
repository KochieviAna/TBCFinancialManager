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
    
    let onLimitAdded: (ExpenseTypeModel) -> Void
    
    private let expenseTypes = [
        "ჯანმრთელობა, სილამაზე",
        "ტრანსპორტი",
        "გართობა",
        "კომუნალურები",
        "მოგზაურობა",
        "რესტორანი, კაფე, ბარი",
        "საოჯახო ხარჯი"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                limitDetailView
                selectExpenseTypeView
                Spacer(minLength: 300)
                setLimitButton
            }
            .navigationTitle("დანახარჯის ლიმიტი")
            .background(Color("backgroundColor"))
        }
        .sheet(isPresented: $isPickerPresented) {
            expensePickerSheet
        }
    }
    
    private var limitDetailView: some View {
        VStack {
            HStack {
                Text("ლიმიტი")
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
                Text("დანახარჯის ტიპი")
                    .font(.popinsRegular(size: 12))
                    .foregroundColor(.primaryBlue)
                
                Spacer()
            }
            
            HStack {
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    Text(selectedExpense?.name ?? "აირჩიე დანახარჯის ტიპი")
                        .font(.popinsLight(size: 12))
                        .foregroundColor(selectedExpense == nil ? .primaryBlack : .primaryBlack)
                }
                .padding(.top)
                
                Spacer()
            }
            
            Divider()
                .foregroundColor(.primaryBlue)
        }
        .padding()
    }
    
    private var expensePickerSheet: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("დასრულება") {
                    isPickerPresented = false
                }
                .foregroundColor(.primaryBlue)
            }
            
            Picker("აირჩიე დანახარჯის ტიპი", selection: $selectedExpense) {
                ForEach(expenseTypes, id: \.self) { type in
                    Text(type).tag(ExpenseTypeModel(name: type, limit: 0, spent: 0))
                }
            }
            .pickerStyle(.wheel)
        }
        .presentationDetents([.height(300), .medium])
        .padding(.horizontal)
    }
    
    private var setLimitButton: some View {
        Button(action: {
            guard let selectedExpense = selectedExpense, let limit = Double(limitAmount) else { return }
            
            var newExpense = selectedExpense
            newExpense.limit = limit
            
            onLimitAdded(newExpense)
            dismiss()
        }) {
            Text("დასრულება")
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
