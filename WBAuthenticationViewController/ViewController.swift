//
//  ViewController.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var authenticateButton : UIButton!
    var changePasscodeButton : UIButton!
    var removePasscodeButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    func setup() {
        
        view.backgroundColor = UIColor.white
        
        authenticateButton = UIButton(type: .custom)
        authenticateButton.setTitleColor(UIColor.black, for: .normal)
        authenticateButton.translatesAutoresizingMaskIntoConstraints = false
        authenticateButton.setTitle("Authenticate / Setup Passcode", for: .normal)
        authenticateButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        view.addSubview(authenticateButton)
        authenticateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authenticateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        changePasscodeButton = UIButton(type: .custom)
        changePasscodeButton.setTitleColor(UIColor.black, for: .normal)
        changePasscodeButton.translatesAutoresizingMaskIntoConstraints = false
        changePasscodeButton.setTitle("Change Passcode", for: .normal)
        changePasscodeButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        view.addSubview(changePasscodeButton)
        changePasscodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePasscodeButton.bottomAnchor.constraint(equalTo: authenticateButton.topAnchor, constant: -20).isActive = true
        
        removePasscodeButton = UIButton(type: .custom)
        removePasscodeButton.setTitleColor(UIColor.black, for: .normal)
        removePasscodeButton.translatesAutoresizingMaskIntoConstraints = false
        removePasscodeButton.setTitle("Remove Passcode", for: .normal)
        removePasscodeButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        view.addSubview(removePasscodeButton)
        removePasscodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        removePasscodeButton.topAnchor.constraint(equalTo: authenticateButton.bottomAnchor, constant: 20).isActive = true
    }

    func buttonPressed(_ sender: UIButton) {
        
        var authenticationVC : WBAuthenticationViewController!
        
        switch sender {
        case authenticateButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(recording: false, changing: false, removing: false)
            } else {
                authenticationVC = WBAuthenticationViewController(recording: true, changing: false, removing: false)
            }
        case changePasscodeButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(recording: false, changing: true, removing: false)
            }
        case removePasscodeButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(recording: false, changing: false, removing: true)
            }
        default:
            break
        }
        
        if authenticationVC != nil {
            present(authenticationVC, animated: true, completion: nil)
        }
    }
}

