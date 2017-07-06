//
//  UIStackView+Init.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(subviews: [UIView]) {
        self.init(frame: CGRect.zero)
    
        axis = .horizontal
        alignment = .fill
        distribution = .equalSpacing
        
        (0..<subviews.count).forEach { i in insertArrangedSubview(subviews[i], at: i) }
    }
}
