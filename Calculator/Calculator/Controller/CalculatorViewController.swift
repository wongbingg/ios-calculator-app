//
//  Calculator - CalculatorViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    private var savedCalculatorItems: String = ""
    
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var savedCalculatorItemsStackView: UIStackView!
    @IBOutlet weak var savedCalculatorItemsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Calculator.applyNumberFormatter()
    }
    
    private func addStackViewLabel() {
        let savedItemlabel = UILabel()
        savedItemlabel.font = UIFont.preferredFont(forTextStyle: .title3)
        savedItemlabel.textColor = .white
        savedItemlabel.adjustsFontSizeToFitWidth = true
        
        if operandLabel.text!.contains(Calculator.decimalPoint) {
            while operandLabel.text!.hasSuffix("0") || operandLabel.text!.hasSuffix(Calculator.decimalPoint) {
                operandLabel.text!.removeLast()
            }
        }
        
        savedItemlabel.text = "\(operatorLabel.text!) \(operandLabel.text!)"
        savedCalculatorItemsStackView.addArrangedSubview(savedItemlabel)
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        savedCalculatorItemsScrollView.layoutIfNeeded()
        let bottomOffset = CGPoint(x: 0, y: savedCalculatorItemsScrollView.contentSize.height - savedCalculatorItemsScrollView.bounds.size.height + savedCalculatorItemsScrollView.contentInset.bottom)
        if(bottomOffset.y > 0) {
            savedCalculatorItemsScrollView.setContentOffset(bottomOffset, animated: false)
        }
    }
    
    private func clearAllStackViewLabel() {
        let addedStackViewLabels = savedCalculatorItemsStackView.arrangedSubviews
        
        addedStackViewLabels.forEach { subview in
            return subview.removeFromSuperview()
        }
    }
    
    @IBAction func tappedResultButton(_ button: UIButton) {
        switch operatorLabel.text!.isEmpty {
        case true:
            return
        case false:
            saveCalculator(item: "\(operatorLabel.text!)")
            saveCalculator(item: "\(operandLabel.text!)")
            addStackViewLabel()
            resetOperatorLabel()
            var parsedFormula = ExpressionParser.parse(from: savedCalculatorItems)
            let result = parsedFormula.result()
            operandLabel.text = Calculator.numberFormatter.string(for: result)
            resetSavedCalculatorItems()
        }
    }
    
    @IBAction func tappedOperandButton(_ button: UIButton) {
        switch operandLabel.text! {
        case Calculator.defaultOperandLabel:
            operandLabel.text = Calculator.emptyString
            operandLabel.text! += button.currentTitle!
        default:
            operandLabel.text! += button.currentTitle!
        }
    }
    
    @IBAction func tappedOperatorButton(_ button: UIButton) {
        switch operatorLabel.text!.isEmpty || operandLabel.text! != Calculator.defaultOperandLabel {
        case true:
            saveCalculator(item: "\(operatorLabel.text!)")
            saveCalculator(item: "\(operandLabel.text!)")
            addStackViewLabel()
            resetOperandLabel()
            operatorLabel.text = button.currentTitle
        case false:
            operatorLabel.text = button.currentTitle
        }
    }
    
    @IBAction func tappedZeroButton(_ button: UIButton) {
        guard var operandLabelText = operandLabel.text,
              let buttonTitle = button.currentTitle else { return }
        
        if operandLabelText != Calculator.defaultOperandLabel {
            operandLabelText += buttonTitle
            operandLabel.text = operandLabelText
        }
    }
    
    @IBAction func tappedDecimalPointButton(_ button: UIButton) {
        switch operandLabel.text!.contains(Calculator.decimalPoint) {
        case true:
            return
        case false:
            operandLabel.text! += button.currentTitle!
        }
    }
    
    @IBAction func tappedChangeSignButton(_ button: UIButton) {
        guard operandLabel.text! != Calculator.defaultOperandLabel else {
            return
        }
        
        switch operandLabel.text!.hasPrefix(Calculator.negativeSign) {
        case true:
            operandLabel.text!.removeFirst()
        case false:
            operandLabel.text! = Calculator.negativeSign + operandLabel.text!
        }
    }
    
    @IBAction func tappedAllClearButton(_ button: UIButton) {
        resetSavedCalculatorItems()
        resetOperandLabel()
        resetOperatorLabel()
        clearAllStackViewLabel()
    }
    
    @IBAction func tappedClearEntryButton(_ button: UIButton) {
        resetOperandLabel()
    }
    
    @IBAction func occurHapticFeedback() {
        Calculator.hapticGenerator.selectionChanged()
    }
    
    private func saveCalculator(item: String) {
        switch item.contains(Calculator.decimalComma) {
        case true:
            let commaRemoveditem = item.components(separatedBy: Calculator.decimalComma).joined()
            savedCalculatorItems += " \(commaRemoveditem)"
        case false:
            savedCalculatorItems += " \(item)"
        }
    }
    
    private func resetSavedCalculatorItems() {
        savedCalculatorItems = Calculator.emptyString
    }
    
    private func resetOperandLabel() {
        operandLabel.text = Calculator.defaultOperandLabel
    }
    
    private func resetOperatorLabel() {
        operatorLabel.text = Calculator.emptyString
    }
}

