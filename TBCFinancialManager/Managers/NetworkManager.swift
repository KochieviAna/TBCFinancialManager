//
//  NetworkManager.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var expenses: [ExpenseTypeModel] = []
    
    private let baseUrl = "YOUR_API_ENDPOINT_URL"
    
    // Fetch expenses from API
    func fetchExpenses() {
        guard let url = URL(string: "\(baseUrl)/expenses") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.expenses = try JSONDecoder().decode([ExpenseTypeModel].self, from: data)
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    // Post new expense data
    func addExpense(_ expense: ExpenseTypeModel) {
        guard let url = URL(string: "\(baseUrl)/expenses") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(expense)
            request.httpBody = jsonData
        } catch {
            print("Error encoding expense: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding expense: \(error)")
                return
            }
            
            guard let _ = data else {
                print("No data received")
                return
            }
            
            DispatchQueue.main.async {
                print("Expense added successfully")
            }
        }.resume()
    }
}
