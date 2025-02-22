//
//  UserFinancesView.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

struct UserFinancesView: View {
    var body: some View {
        NavigationStack {
            VStack {

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Financical Manager")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image("burger.menu")
                                .resizable()
                                .frame(width: 37, height: 22)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .font(.title.bold())
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.primaryBlue)
                        }
                    }
                }
            }
            .background(Color("backgroundColor"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    UserFinancesView()
}
