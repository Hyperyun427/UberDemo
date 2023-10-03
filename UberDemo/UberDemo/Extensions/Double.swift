//
//  Double.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-10-02.
//

import Foundation


extension Double{
    private var currencyFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrent() -> String{
        return currencyFormatter.string(for:self) ?? ""
    }
}
