//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by mmim.
//

import Foundation

struct CalculatorItemQueue<Element: CalculatorItem> {
    var inputStack: [Element] = []
    var outputStack: [Element] = []
    
    mutating func enqueue(_ element: Element) {
        inputStack.append(element)
    }
}

protocol CalculatorItem { }

extension Double: CalculatorItem { }

enum Operator: CalculatorItem {
    case plus
    case minus
    case divide
    case multiply
}
