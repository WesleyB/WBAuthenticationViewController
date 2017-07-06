//
//  UIView+shake.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/6/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake(_ duration: CFTimeInterval, completion: () -> Void) {
        
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shake.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        shake.duration = duration
        
        layer.add(shake, forKey: "shake")
        
        completion()
    }
}
