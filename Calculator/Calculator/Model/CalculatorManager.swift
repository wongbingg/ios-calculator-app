//
//  CalculatorManager.swift
//  Calculator
//
//  Created by 이승재 on 2021/11/15.
//

import Foundation

struct CalculatorManager {
    var isCalculating : Bool
    private let numberFormatter = NumberFormatter()

    init(isCalculating: Bool){
        self.isCalculating = isCalculating
    }
    
    func format(of numberExpression: String) -> String {
        let numberExpressionWithoutDecimal = numberExpression
            .replacingOccurrences(of: ",", with: "")
        guard let number = Double(numberExpressionWithoutDecimal) else {
            return "0"
        }
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumSignificantDigits = 1
        numberFormatter.maximumSignificantDigits = 20
        
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) else {
            return "0"
        }
        
        return formattedNumber
    }
}
