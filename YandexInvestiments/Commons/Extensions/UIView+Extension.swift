//
//  UIView+Extension.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 15.06.2021.
//

import Foundation
import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
