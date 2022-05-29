//
//  UILabel+Extensions.swift
//  Calculator
//
//  Created by 이원빈 on 2022/05/29.
//

import Foundation
import UIKit

extension UILabel {
    func setAttribute(font: UIFont.TextStyle, color: UIColor) {
        self.font = UIFont.preferredFont(forTextStyle: font)
        self.textColor = color
    }
}

