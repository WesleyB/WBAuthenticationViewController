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
        self.init(frame: CGRect(x: 0, y: 0, width: UIConstants.indicatorViewSize, height: UIConstants.indicatorViewSize))
        
        self.tag = tag
        setup()
    }
    
    func setup() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        clipsToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
    }
    
    func animateFillIn() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = UIColor.black
        })
    }
    
    func animateUnfill() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = UIColor.clear
        })
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        layer.cornerRadius = frame.width / 2
    }
}
