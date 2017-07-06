//
//  WBKeypadButton.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

class WBKeypadButton: UIButton {
    
    var identifier : Int = 0
    
    convenience init(identifier: Int) {
        self.init(frame: CGRect.zero)
        
        self.identifier = identifier
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = rect.width / 2
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func setup() {
        
        setTitle("\(identifier)", for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
