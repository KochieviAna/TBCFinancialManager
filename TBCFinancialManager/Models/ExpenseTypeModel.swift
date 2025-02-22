//
//  ExpenseTypeModel.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

struct ExpenseTypeModel: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    var limit: Double
    var spent: Double
    
    // Computed properties for remaining balance, exceeded amount, and formatted values
    var remainingBalance: Double {
        return limit - spent
    }
    
    var exceededAmount: Double {
        return max(0, spent - limit)
    }
    
    var formattedSpent: String {
        return String(format: "%.2f", spent)
    }
    
    var formattedExceeded: String {
        return String(format: "%.2f", exceededAmount)
    }
    
    var formattedLimit: String {
        return String(format: "%.2f", limit)
    }
    
    var formattedRemainingBalance: String {
        return String(format: "%.2f", remainingBalance)
    }
    
    // Conformance to Hashable protocol
    static func == (lhs: ExpenseTypeModel, rhs: ExpenseTypeModel) -> Bool {
        return lhs.id == rhs.id // compare by ID for equality
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // combine id for hashing
    }
}
