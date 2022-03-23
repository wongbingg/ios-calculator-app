//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Lingo on 2022/03/14.
//

import UIKit

final class CalculatorViewController: UIViewController {
  
  @IBOutlet private weak var resultScrollView: UIScrollView!
  @IBOutlet private weak var resultStackView: UIStackView!
  @IBOutlet private weak var operatorLabel: UILabel!
  @IBOutlet private weak var operandLabel: UILabel!
  
  private let viewModel = CalculatorViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindUI()
    self.clearAll()
  }
  
  @IBAction private func didTapKeyOperationButton(_ sender: UIButton) {
    guard let keyOperation = sender.titleLabel?.text else {
      return
    }
    switch keyOperation {
    case "AC":
      self.clearAll()
    case "CE":
      self.clearEntry()
    case "⁺⁄₋":
      self.convertSign()
    default: break
    }
  }
  
  @IBAction private func didTapCalculateButton(_ sender: UIButton) {
    guard let stackView = self.viewModel.makeSubResultStackView() else {
      return
    }
    if self.viewModel.didTapCalculateButton() {
      self.resultStackView.addArrangedSubview(stackView)
    }
  }
  
  @IBAction private func didTapOperatorButton(_ sender: UIButton) {
    guard let operatorString = sender.titleLabel?.text else {
      return
    }
    guard let stackView = self.viewModel.makeSubResultStackView() else {
      return
    }
    if self.viewModel.didTapOperatorButton(of: operatorString) {
      self.resultStackView.addArrangedSubview(stackView)
    }
  }
  
  @IBAction private func didTapNumberButton(_ sender: UIButton) {
    guard let numberString = sender.titleLabel?.text else {
      return
    }
    self.viewModel.didTapNumberButton(of: numberString)
  }
  
  @IBAction private func didTapDotButton(_ sender: UIButton) {
    self.viewModel.didTapDotButton()
  }
}

// MARK: - Private Extension

private extension CalculatorViewController {
  
  func bindUI() {
    self.viewModel.operatorType.bind { [weak self] operatorType in
      self?.operatorLabel.text = operatorType
    }
    self.viewModel.operandValue.bind { [weak self] operand in
      self?.changeOperandLabel(of: operand)
    }
  }
  
  func changeOperandLabel(of operand: String) {
    guard self.viewModel.isResult == true else {
      self.operandLabel.text = operand
      return
    }
    guard let operand = Double(operand) else {
      return
    }
    self.operandLabel.text = operand.formatString()
    self.viewModel.isResult = false
  }
  
  func clearAll() {
    self.viewModel.clearAll()
    self.resultStackView.arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
  }
  
  func clearEntry() {
    self.viewModel.clearEntry()
  }

  func convertSign() {
    self.viewModel.convertSign()
  }
}
