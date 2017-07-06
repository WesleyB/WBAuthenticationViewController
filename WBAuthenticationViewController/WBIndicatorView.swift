//
//  WBIndicatorView.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

class WBIndicatorView: UIView {
    
    convenience init(tag: Int) {
        self.init(frame: CGRect.zero)
        
        self.tag = tag
        setup()
    }

    override func draw(_ rect: CGRect) {
        
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = rect.width / 2
    }
    
    func setup() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
    
    func animateFillIn() {
        
        UIView.animate(withDuration: 1, animations: {
            self.backgroundColor = UIColor.black
        })
    }
    
    func animateUnfill() {
        
        UIView.animate(withDuration: 1, animations: {
            self.backgroundColor = UIColor.clear
        })
    }
}
