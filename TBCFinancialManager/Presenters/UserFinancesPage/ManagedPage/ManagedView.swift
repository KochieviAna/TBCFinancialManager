//
//  ManagedView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct ManagedView: View {
    @State private var progress = 0.5
    
    var body: some View {
        ScrollView {
            VStack {
                assetsView
                
                limitedExpencesView
            }
        }
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
    
    private var limitedExpencesView: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("Clothing")
                        .font(.popinsLight(size: 12))
                        .foregroundStyle(.primaryBlack)
                }
                
                Spacer()
                
                Text("Limit: 100 GEL")
                    .font(.popinsLight(size: 12))
                    .foregroundStyle(.primaryBlack)
            }
            
            ProgressView(value: progress)
            
            HStack {
                Text("Spent: 75 GEL")
                    .font(.popinsLight(size: 12))
                    .foregroundStyle(.primaryBlack)
                
                Spacer()
                
                Text("Remaining Balance: 25 GEL")
                    .font(.popinsLight(size: 12))
                    .foregroundStyle(.primaryBlack)
            }
        }
        .padding()
    }
}

#Preview {
    ManagedView()
}
