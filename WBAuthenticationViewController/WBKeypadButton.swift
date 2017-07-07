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
        self.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: ViewDimensions.view.keypadButton.dimension, height: ViewDimensions.view.keypadButton.dimension)))
        
        self.identifier = identifier
        setup()
    }
    
    func setup() {
        
        backgroundColor = UIColor.white
        
        setTitle("\(identifier)", for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
        
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        layer.cornerRadius = frame.width / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animateBackground(UIColor.black)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        touchesEnded(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animateBackground(UIColor.white)
    }
    
    func animateBackground(_ withColor: UIColor) {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = withColor
        })
    }
}
