//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

enum NameSpace {
    static let comma: Character = ","
    static let dot = "."
    static let zero = "0"
    static let emptyText = ""
    static let space = " "
    static let nanError = "NaN"
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var screenLabel: UILabel?
    @IBOutlet private weak var currentOperatorLabel: UILabel?
    @IBOutlet private weak var historyStackView: UIStackView?
    @IBOutlet private weak var historyScrollView: UIScrollView?
    
    private var formula: Formula?
    private let numberFormatter = NumberFormatter()
    private var alreadyCalculatedStackCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = -2
        numberFormatter.maximumIntegerDigits = 20
        screenLabel?.text = NameSpace.zero
        removeAllIn(stack: historyStackView!)
    }
    //MARK: - buttons
    
    @IBAction private func operandButtonDidTapped(_ sender: UIButton) {
        guard screenLabel?.text != NameSpace.nanError else { allClear(); return }
        guard let textCount = screenLabel?.text?.count else { return }
        guard textCount <= 25 else { return }
        if screenLabel?.text == NameSpace.zero {
            screenLabel?.text = NameSpace.emptyText
        }
        adoptNumberFormatter(with: sender)
    }
    
    @IBAction func dotButtonDidTapped(_ sender: UIButton) {
        screenLabel?.text = (screenLabel?.text ?? emptyText) + "."
        guard screenLabel?.text != NameSpace.nanError else { allClear(); return }
    }
    
    @IBAction func doubleZeroButtonDidTapped(_ sender: UIButton) {
        guard screenLabel?.text != zero else { return }
        adoptNumberFormatter(with: sender)
        guard screenLabel?.text != NameSpace.nanError else { allClear(); return }
    }
    
    @IBAction private func operatorButtonDidTapped(_ sender: UIButton) {
        guard screenLabel?.text != NameSpace.nanError else { allClear(); return }
        
        if screenLabel?.text != NameSpace.zero {
            add(generateStackView(), to: historyStackView)
        } else if screenLabel?.text == NameSpace.zero && currentOperatorLabel?.text == NameSpace.emptyText {
            return
        }
        currentOperatorLabel?.text = sender.currentTitle
        screenLabel?.text = NameSpace.zero
        goToBottomOfScrollView()
    }
    
    @IBAction private func equalButtonDidTapped(_ sender: UIButton) {
        
        guard currentOperatorLabel?.text != emptyText else { return }
        add(generateStackView(), to: historyStackView)
        currentOperatorLabel?.text = NameSpace.emptyText
        
        guard let historyStackView = historyStackView else { return }
        formula = ExpressionParser.parse(from: fetchTextData(from: historyStackView, start: alreadyCalculatedStackCount))
        
        guard let existFormula = formula else { return }
        alreadyCalculatedStackCount += existFormula.operands.count
        
        do {
            let result = try formula?.result()
            screenLabel?.text = numberFormatter.string(for: result)
        } catch {
            switch error as? CalculatorError {
            case .dividedByZero:
                screenLabel?.text = NameSpace.nanError
            case .notEnoughInput:
                print("입력값을 추가하세요.")
            case .emptyStack:
                print("Stack이 비었습니다")
            default:
                return
            }
        }
        goToBottomOfScrollView()
    }
    
    @IBAction private func functionButtonDidTapped(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "AC":
            allClear()
        case "⁺⁄₋":
            guard let operand = screenLabel?.text else { return }
            guard screenLabel?.text != NameSpace.zero else { return }
            var operandText = operand
            operandText.removeEntire(character: ",")
            screenLabel?.text = numberFormatter.string(for: (Double(operandText) ?? 0) * -1)
        case "CE":
            screenLabel?.text = NameSpace.zero
        default:
            return
        }
    }
    //MARK: - methods
    
    private func removeAllIn(stack: UIStackView) {
        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.isHidden = true
        }
    }
    
    private func add(_ subStack: UIStackView, to parentStack: UIStackView?) {
        parentStack?.addArrangedSubview(subStack)
        UIView.animate(withDuration: 0.2) {
            subStack.isHidden = false
        }
    }
    
    private func generateStackView() -> UIStackView {
        let stackViewElement = UIStackView()
        stackViewElement.axis = .horizontal
        stackViewElement.isHidden = true
        stackViewElement.spacing = 8
        
        let operatorLabel = UILabel()
        operatorLabel.text = currentOperatorLabel?.text
        operatorLabel.setAttribute(font: .title3, color: UIColor(white: 1, alpha: 1))
        stackViewElement.addArrangedSubview(operatorLabel)
        
        let operandLabel = UILabel()
        operandLabel.text = screenLabel?.text
        operandLabel.setAttribute(font: .title3, color: UIColor(white: 1, alpha: 1))
        stackViewElement.addArrangedSubview(operandLabel)
        
        return stackViewElement
    }
    
    private func goToBottomOfScrollView() {
        guard let scrollView = historyScrollView else { return }
        scrollView.scrollRectToVisible(CGRect(x: 0,
                                              y: scrollView.contentSize.height - scrollView.bounds.height,
                                              width: scrollView.bounds.size.width,
                                              height: scrollView.bounds.size.height),
                                       animated: true)
    }
    
    private func fetchTextData(from stackView: UIStackView, start: Int) -> String {
        var textData = NameSpace.emptyText
        for subStackView in stackView.arrangedSubviews[start...] {
            subStackView.subviews.forEach {
                if let label = $0 as? UILabel {
                    textData += NameSpace.space + (label.text ?? NameSpace.emptyText)
                    textData.removeEntire(character: NameSpace.comma)
                }
            }
        }
        return textData
    }
    
    private func adoptNumberFormatter(with sender: UIButton) {
        var totalText = (screenLabel?.text ?? emptyText) + (sender.currentTitle ?? emptyText)
        totalText.removeEntire(character: ",")
        screenLabel?.text = numberFormatter.string(for: Double(totalText) ?? zero)
    private func allClear() {
        guard let historyStackView = historyStackView else { return }
        alreadyCalculatedStackCount = 0
        screenLabel?.text = NameSpace.zero
        currentOperatorLabel?.text = NameSpace.emptyText
        removeAllIn(stack: historyStackView)
    }
}
