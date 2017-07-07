//
//  Constants.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/6/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

struct ViewDimensions {
    
    enum view {
        case keypadButton
        case indicatorView
        case keypadRow
        case keypadStackView
        
        var dimension : CGFloat {
            switch self {
            case .keypadButton: return UIScreen.main.bounds.width/5
            case .indicatorView: return UIScreen.main.bounds.width/15
            default: return 0
            }
        }
        
        var width : CGFloat {
            switch self {
            //case .indicatorStackView: return UIScreen.main.bounds.width/2.93
            case .keypadRow: return UIScreen.main.bounds.width/1.34
            default: return 0
            }
        }
        
        var height : CGFloat {
            switch self {
            case .keypadStackView: return UIScreen.main.bounds.height/1.933
            default: return 0
            }
        }
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
        
        var key : String {
            switch self {
            case .wantsAuthentication: return "wantsAuthentication"
            }
        }
    }
}
