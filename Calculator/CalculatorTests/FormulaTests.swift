//
//  FormulaTests.swift
//  CalculatorTests
//
//  Created by Ari on 2021/11/10.
//

import XCTest

extension String {
    func split(with target: Character) -> [String] {
        self.split(separator: target).map { String($0) } + [String(target)]
    }
}

class FormulaTests: XCTestCase {

    func test_더하기연산해보기_피연산자한개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("+")
        let result = formula.result()
        
        XCTAssertEqual(result, 0.0)
    }
    
    func test_더하기연산해보기_피연산자두개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("+")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("+")
        let result = formula.result()
        
        XCTAssertEqual(result, 4.0)
    }
    
    func test_더하기연산해보기_피연산자세개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("+")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("+")
        formula.operands.enqueue(2.0)
        let result = formula.result()
        
        XCTAssertEqual(result, 6.0)
    }
    
    func test_빼기연산해보기_피연산자한개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("-")
        let result = formula.result()
        
        XCTAssertEqual(result, 0)
    }
    
    func test_빼기연산해보기_피연산자두개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("-")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("-")
        let result = formula.result()
        
        XCTAssertEqual(result, 0.0)
    }
    
    func test_빼기연산해보기_피연산자세개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("-")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("-")
        formula.operands.enqueue(2.0)
        let result = formula.result()
        
        XCTAssertEqual(result, -2.0)
    }
    
    func test_곱셈연산해보기_피연산자한개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("*")
        let result = formula.result()
        
        XCTAssertEqual(result, 0)
    }
    
    func test_곱셈연산해보기_피연산자두개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("*")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("*")
        let result = formula.result()
        
        XCTAssertEqual(result, 4.0)
    }
    
    func test_곱셈연산해보기_피연산자세개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("*")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("*")
        formula.operands.enqueue(2.0)
        let result = formula.result()
        
        XCTAssertEqual(result, 8.0)
    }
    
    func test_나눗셈연산해보기_피연산자한개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        let result = formula.result()
        
        XCTAssertEqual(result, 0)
    }
    
    func test_나눗셈연산해보기_피연산자두개_연산자두개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        let result = formula.result()
        
        XCTAssertEqual(result, 1.0)
    }
    
    func test_나눗셈연산해보기_피연산자세개() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        formula.operands.enqueue(2.0)
        let result = formula.result()
        
        XCTAssertEqual(result, 0.5)
    }
    
    func test_나눗셈연산해보기_0을나눌때() {
        var formula = Formula()
        
        formula.operands.enqueue(2.0)
        formula.operators.enqueue("/")
        formula.operands.enqueue(0)
        let result = formula.result()
        
        XCTAssertTrue(result.isNaN)
    }
}
