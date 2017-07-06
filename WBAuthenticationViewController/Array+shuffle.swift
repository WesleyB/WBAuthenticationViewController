//
//  Array+shuffle.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/6/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func shuffle() {
        
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}
