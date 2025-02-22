//
//  ExpenseTypeModel.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

public struct ExpenseTypeModel: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let image: String?
    public let darkColor: Color
    public let lightColor: Color

    init(name: String, image: String? = nil, darkColor: Color, lightColor: Color) {
        self.name = name
        self.image = image
        self.darkColor = darkColor
        self.lightColor = lightColor
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: ExpenseTypeModel, rhs: ExpenseTypeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
