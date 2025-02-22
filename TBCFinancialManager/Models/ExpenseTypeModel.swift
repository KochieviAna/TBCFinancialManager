//
//  ExpenseTypeModel.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct ExpenseTypeModel: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var limit: Double
    var spent: Double
    
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
}


