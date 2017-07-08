//
//  WBKeypadButton.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

class WBKeypadButton: UIButton {
    
    // MARK: - Variables
    var keyTitleLabel : UILabel!
    var keySublabel : UILabel?
    var keySublabelHeightAnchor : NSLayoutConstraint?
    
    var identifier : String = ""
    var subtext : String?
    var shouldPadEmptySubtext : Bool = false
    
    // MARK: - Initializers
    convenience init(identifier: Int) {
        self.init()
        
        self.identifier = identifier.string
        setup()
    }
    
    convenience init(identifier: Int, subtext: String?) {
        self.init()
        
        self.identifier = identifier.string
        self.subtext = subtext
        setup()
    }
    
    convenience init(identifier: Int, autoGenerateSubtext: Bool) {
        self.init()
        
        self.identifier = identifier.string
        self.subtext = generateSubtext(identifier)
        setup()
    }
    
    convenience init(stringIdentifier: String) {
        self.init()
        
        self.identifier = stringIdentifier
        setup()
    }
    
    convenience init(stringIdentifier: String, subtext: String?) {
        self.init()
        
        self.identifier = stringIdentifier
        self.subtext = subtext
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIConstants.keypadButtonSize, height: UIConstants.keypadButtonSize)))
    }
    
    // MARK: - Functions
    func setup() {
        
        backgroundColor = UIColor.white
        
        let container = UIView(frame: CGRect(origin: CGPoint.zero, size: UIConstants.keypadLabelContainerSize))
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.isUserInteractionEnabled = false
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: UIConstants.keypadLabelContainerSize.width).isActive = true
        container.heightAnchor.constraint(equalToConstant: UIConstants.keypadLabelContainerSize.height).isActive = true
        
        keyTitleLabel = UILabel()
        keyTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 144)
        keyTitleLabel.adjustsFontSizeToFitWidth = true
        keyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        keyTitleLabel.numberOfLines = 0
        keyTitleLabel.textAlignment = .center
        keyTitleLabel.text = "\(identifier)"
        container.addSubview(keyTitleLabel)
        keyTitleLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        keyTitleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        keySublabel = UILabel()
        keySublabel?.font = UIFont(name: "HelveticaNeue-Light", size: 144)
        keySublabel?.adjustsFontSizeToFitWidth = true
        keySublabel?.translatesAutoresizingMaskIntoConstraints = false
        keySublabel?.textAlignment = .center
        keySublabel?.numberOfLines = 0
        if subtext != nil {
            keySublabel?.text = subtext
        } else {
            if shouldPadEmptySubtext {
                keySublabel?.text = ""
            }
        }
        container.addSubview(keySublabel!)
        keySublabel?.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        keySublabel?.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        keySublabel?.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        keySublabelHeightAnchor = keySublabel?.heightAnchor.constraint(equalToConstant: 10)
        keySublabelHeightAnchor?.isActive = true
        keyTitleLabel.bottomAnchor.constraint(equalTo: keySublabel!.topAnchor).isActive = true

        if subtext == nil && shouldPadEmptySubtext == false {
            keySublabelHeightAnchor?.constant = 0
            keySublabel?.updateConstraints()
        }

        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        layer.masksToBounds = false
    }
    
    func generateSubtext(_ identifier: Int) -> String? {
        
        switch identifier {
        case 0, 1: return nil
        case 2: return "A B C"
        case 3: return "D E F"
        case 4: return "G H I"
        case 5: return "J K L"
        case 6: return "M N O"
        case 7: return "P Q R S"
        case 8: return "T U V"
        case 9: return "W X Y Z"
        default: return nil
        }
    }
    
    func animateBackground(_ bg: UIColor, textColor: UIColor?) {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = bg
            self.keyTitleLabel.textColor = textColor
            self.keySublabel?.textColor = textColor
        })
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animateBackground(UIColor.black, textColor: UIColor.white)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        touchesEnded(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animateBackground(UIColor.white, textColor: UIColor.black)
    }
}

























