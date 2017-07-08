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
    var touchIDSwitch : UISwitch!
    
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
        
        touchIDSwitch = UISwitch()
        touchIDSwitch.translatesAutoresizingMaskIntoConstraints = false
        touchIDSwitch.setOn(UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.touchIDEnabled.key), animated: true)
        touchIDSwitch.addTarget(self, action: #selector(touchIDSwitchToggled(_:)), for: .valueChanged)
        view.addSubview(touchIDSwitch)
        touchIDSwitch.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -30).isActive = true
        touchIDSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let touchIDLabel = UILabel()
        touchIDLabel.translatesAutoresizingMaskIntoConstraints = false
        touchIDLabel.text = "Enable Touch ID?"
        view.addSubview(touchIDLabel)
        touchIDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        touchIDLabel.bottomAnchor.constraint(equalTo: touchIDSwitch.topAnchor, constant: -10).isActive = true
    }

    func buttonPressed(_ sender: UIButton) {
        
        var authenticationVC : WBAuthenticationViewController!
        
        switch sender {
        case authenticateButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(authMode: .authenticate)
            } else {
                authenticationVC = WBAuthenticationViewController(authMode: .setupPasscode)
            }
        case changePasscodeButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(authMode: .changePasscode)
            }
        case removePasscodeButton:
            if UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.wantsAuthentication.key) == true {
                authenticationVC = WBAuthenticationViewController(authMode: .removePasscode)
            }
        default:
            break
        }
        
        if authenticationVC != nil {
            present(authenticationVC, animated: true, completion: nil)
        }
    }
    
    func touchIDSwitchToggled(_ sender: UISwitch) {
        
        UserDefaults.standard.set(sender.isOn, forKey: DataConstants.UserDefaults.touchIDEnabled.key)
        UserDefaults.standard.synchronize()
    }
}

