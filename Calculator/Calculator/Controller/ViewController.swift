//
//  Calculator - ViewController.swift
//  Created by DuDu
//

import UIKit

private enum Digit {
    static let limitDigit = 20
    static let limitNumber = 1.0e20
}

private enum NumberString {
    static let empty = ""
    static let zero = "0"
    static let nan = "NaN"
}

final class ViewController: UIViewController {
    private var currentStringNumber: String = NumberString.empty
    private var expression: [String?] = []
    private var isInputExist: Bool = false
    private var isCalculateValue: Bool = false
    
    @IBOutlet private var logScrollView: UIScrollView!
    @IBOutlet private var calculateLogStackView: UIStackView!
    
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var operatorLabel: UILabel!
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = Digit.limitDigit
        formatter.roundingMode = .floor
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = NumberString.zero
        logScrollView.showsVerticalScrollIndicator = false
    }
    
    @IBAction private func numberButtonDidTapped(_ sender: UIButton) {
        if numberLabel.text == NumberString.nan {
            return
        }
        
        if currentStringNumber.count >= Digit.limitDigit {
            return
        }
        
        if isCalculateValue {
            isCalculateValue = false
            resetCalculator()
        }
        
        guard let inputNumber = sender.titleLabel?.text else {
            return
        }
        
        if ["00","0"].contains(inputNumber), numberLabel.text == NumberString.nan {
            isInputExist = true
            return
        }
        
        isInputExist = true
        currentStringNumber += inputNumber
        numberLabel.text = currentStringNumber
    }
    
    @IBAction private func operatorButtonDidTapped(_ sender: UIButton) {
        writeCalculateLog()
        operatorLabel.text = sender.titleLabel?.text
    }
    
    private func writeCalculateLog() {
        if numberLabel.text == NumberString.nan {
            return
        }
        
        if isInputExist == false {
            return
        }
        
        
        
        let doubleNumber = numberLabel.text?.replacingOccurrences(of: ",", with: "")
        let numberLogLabel = makeLabel(with: doubleNumber)
        let operatorLogLabel = makeLabel(with: operatorLabel.text)
        
        let stackView = UIStackView(arrangedSubviews: [operatorLogLabel, numberLogLabel])
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = 10
        
        calculateLogStackView.addArrangedSubview(stackView)
        logScrollView.scroll()
        expression.append(contentsOf: [operatorLabel.text, doubleNumber])
    
        isCalculateValue = false
        isInputExist = false
        currentStringNumber = NumberString.empty
        numberLabel.text = NumberString.zero
        operatorLabel.text = NumberString.empty
    }
    
    private func makeLabel(with text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        return label
    }
    
    @IBAction private func dotButtonDidTapped(_ sender: UIButton) {
        if numberLabel.text == NumberString.nan {
            return
        }
        
        if currentStringNumber.contains(".") {
            return
        }
        
        if isCalculateValue {
            return
        }
        
        if currentStringNumber.count >= Digit.limitDigit {
            return
        }

        if currentStringNumber.isEmpty {
            currentStringNumber = NumberString.zero
        }
        
        currentStringNumber += "."
        numberLabel.text = currentStringNumber
    }
    
    @IBAction private func acButtonDidTapped(_ sender: UIButton) {
        resetCalculator()
    }
    
    private func resetCalculator() {
        expression.removeAll()
        isInputExist = false
        currentStringNumber = NumberString.empty
        numberLabel.text = NumberString.zero
        operatorLabel.text = NumberString.empty
        
        
        calculateLogStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
    @IBAction private func ceButtonDidTapped(_ sender: UIButton) {
        if numberLabel.text == NumberString.nan {
            return
        }
        
        currentStringNumber = NumberString.empty
        numberLabel.text = NumberString.zero
        isInputExist = false
    }
    
    @IBAction private func signButtonDidTapped(_ sender: UIButton) {
        if numberLabel.text == NumberString.zero {
            return
        }
        
        guard let number = Double(currentStringNumber) else {
            return
        }
        
        if number < .zero {
            currentStringNumber.removeFirst()
        } else {
            currentStringNumber.insert("-", at: currentStringNumber.startIndex)
        }
        
        numberLabel.text = currentStringNumber
    }
    
    @IBAction private func calculateButtonDidTapped(_ sender: UIButton) {

        if expression.isEmpty {
            return
        }
                
        writeCalculateLog()
        
        let expressionString = expression.compactMap{$0}.joined(separator: " ")
        expression.removeAll()
        currentStringNumber = NumberString.empty
        
        do {
            let calculateResult = try ExpressionParser.parse(from: expressionString).result()
            numberLabel.text = adjust(number: calculateResult)
            
            isCalculateValue = true
            isInputExist = true
        } catch {
            numberLabel.text = NumberString.nan
        }
    }
    
    private func adjust(number: Double) -> String? {
        let splitedNumber = String(number).split(with: ".")
        let integerDigits = splitedNumber[0]
        
        if integerDigits.count > Digit.limitDigit || number >= Digit.limitNumber {
            return NumberString.nan
        } else {
            return numberFormatter.string(from: number as NSNumber)
        }
    }
    
}

