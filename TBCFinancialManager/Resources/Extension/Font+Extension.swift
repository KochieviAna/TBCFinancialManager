//
//  Font+Extension.swift
//  TBCFinancialManager
//
//  Created by MacBook on 22.02.25.
//

import SwiftUI

extension Font {
    static func popinsBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: size)
    }
    
    static func popinsLight(size: CGFloat) -> Font {
        return Font.custom("Poppins-Light", size: size)
    }
    
    static func popinsRegular(size: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: size)
    }
    
    static func popinsSemiBold(size: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: size)
    }
}
