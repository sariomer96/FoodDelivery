//
//  Constants.swift
//  GraduationProject
//
//  Created by Omer on 17.10.2023.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    let tl = "₺"
    let userName = "s_omer_sari"
    let foodDetailId = "toDetail"
    private init () { }
    
    
    enum Errors:Error {
        case _const
        
    }
}

struct ConstantCurrencies {
    static let TurkishCurrency = "₺"
}
