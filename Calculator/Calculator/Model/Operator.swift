//
//  Operator.swift
//  Calculator
//
//  Created by 조민호 on 2022/03/17.
//

import Foundation

enum Operator: Character, CaseIterable, CalculateItem {
    case add = "+"
}

extension Operator {
    func calculate(lhs: Double, rhs: Double) -> Double {
        switch self {
        case .add:
            return add(lhs: lhs, rhs: rhs)
        }
    }
    
    private func add(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
}
