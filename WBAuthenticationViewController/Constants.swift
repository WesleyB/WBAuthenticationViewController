//
//  Constants.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/6/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

struct UIConstants {
    
    // 562 / 667 scale is based on iPhone 6 dimensions in pts
    // keypadWidth / screenWidth
    
    static var indicatorViewSpacing : CGFloat {
        
        let scaleFactor : CGFloat = 562 / 667
        var space = UIScreen.main.bounds.width >= 375 ? 26 : 26 * scaleFactor
        if UIScreen.main.bounds.width >= 1024 { space += space*0.66 }
        return space
    }
    
    static var indicatorViewSize : CGFloat {
        
        let scaleFactor : CGFloat = 562 / 667
        var size = UIScreen.main.bounds.width >= 375 ? 12.5 : 12.5 * scaleFactor
        if UIScreen.main.bounds.width >= 1024 { size += size*0.66 }
        return size
    }
    
    static var keypadRowWidth : CGFloat {
        
        return keypadSize.width
    }
    
    static var keypadButtonSize : CGFloat {
        
        let spacing = keypadSpacing * 2
        let keySize = (keypadSize.width - spacing) / 3
        return keySize
    }
    
    static var keypadSize : CGSize {
        
        let scaleFactor : CGFloat = 562 / 667
        var width = UIScreen.main.bounds.width >= 375 ? 281 : 281 * scaleFactor
        var height = UIScreen.main.bounds.height >= 667 ? 345 : 345 * scaleFactor
        if UIScreen.main.bounds.width >= 1024 {
            width += width*0.66
            height += height*0.66
        }
        return CGSize(width: width, height: height)
    }
    
    static var keypadSpacing : CGFloat {
        
        let scaleFactor : CGFloat = 562 / 667
        var space = UIScreen.main.bounds.width >= 375 ? 28 : 28 * scaleFactor
        if UIScreen.main.bounds.width >= 1024 { space += space*0.66 }
        return space
    }
    
    static var keypadLabelContainerSize : CGSize {
        
        let size = ceil(keypadButtonSize * 0.66)
        return CGSize(width: size, height: size)
    }
}

struct DataConstants {
    
    enum Animations {
        case shake
        
        var duration : Double {
            switch self {
            case .shake: return 1
            }
        }
    }
    
    enum UserDefaults {
        case wantsAuthentication
        case touchIDEnabled
        
        var key : String {
            switch self {
            case .wantsAuthentication: return "wantsAuthentication"
            case .touchIDEnabled: return "touchIDEnabled"
            }
        }
    }
}
