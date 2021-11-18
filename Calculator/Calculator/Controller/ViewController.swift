//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var processScrollView: UIStackView!
    @IBOutlet weak var signLabel: UILabel!
    
    var inputString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetResult()
    }
    
    func resetResult() {
        resultLabel.text = "0"
        signLabel.text = ""
    }
    
    @IBAction func touchUpAllClearBtn(_ sender: UIButton) {
    }
    @IBAction func touchUpClearEntryBtn(_ sender: UIButton) {
    }
    @IBAction func touchUpSignChangeBtn(_ sender: UIButton) {
    }
    
    @IBAction func touchUpDivideOperator(_ sender: UIButton) {
    }
    @IBAction func touchUpMultiplyOperator(_ sender: UIButton) {
    }
    @IBAction func touchUpSubtractOperator(_ sender: UIButton) {
    }
    @IBAction func touchUpAddOperator(_ sender: UIButton) {
        
    }
    @IBAction func touchUpResultBtn(_ sender: UIButton) {
        var formula: Formula = ExpressionParser.parse(from: inputString)
        do {
            let result: Double = try formula.result()
            resultLabel.text = "\(result)"
        } catch CalculatorError.dividedByZero {
            resultLabel.text = "\(CalculatorError.dividedByZero.description)"
        } catch {
            print(error)
        }
    }
    
    @IBAction func touchUp0Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp00Btn(_ sender: UIButton) {
    }
    @IBAction func touchUpDotBtn(_ sender: UIButton) {
    }
    @IBAction func touchUp1Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp2Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp3Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp4Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp5Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp6Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp7Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp8Btn(_ sender: UIButton) {
    }
    @IBAction func touchUp9Btn(_ sender: UIButton) {
    }
    

}
