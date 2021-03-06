//
//  WBAuthenticationViewController.swift
//  WBAuthenticationViewController
//
//  Created by Wesley Bevins on 7/5/17.
//  Copyright © 2017 Wesley Bevins. All rights reserved.
//

import UIKit
import AudioToolbox
import LocalAuthentication

class WBAuthenticationViewController: UIViewController {

    // MARK: - Variables
    fileprivate var infoLabel : UILabel!
    fileprivate lazy var indicatorViews = [WBIndicatorView]()
    fileprivate lazy var keypadButtons = [WBKeypadButton]()
    fileprivate var indicatorStackView : UIStackView!
    fileprivate var keypadStackView : UIStackView!
    fileprivate var presenter : Any?
    
    fileprivate lazy var context = LAContext()
    fileprivate var keychainWrapper = KeychainWrapper()
    
    fileprivate var userWantsTouchID : Bool {
        get {
            return UserDefaults.standard.bool(forKey: DataConstants.UserDefaults.touchIDEnabled.key)
        }
    }
    fileprivate var shouldOfferTouchID : Bool = true
    enum AuthMode {
        case authenticate
        case setupPasscode
        case changePasscode
        case removePasscode
    }
    fileprivate var authMode : AuthMode!
    fileprivate var recording : Bool = false
    fileprivate var recordingVerification : Bool = false
    fileprivate var changingPasscode : Bool = false
    fileprivate var removingPasscode : Bool = false
    
    fileprivate var shouldScrambleButtons : Bool = false
    
    fileprivate var numberOfItemsPressed : Int = 0
    fileprivate let passcodeLength : Int = 4
    fileprivate var authString = ""
    fileprivate var authCheckString = ""
    
    override var shouldAutorotate: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        }
        return true
    }
    
    // MARK: - Initializers
    convenience init(authMode: AuthMode) {
        let recording = authMode == .setupPasscode,
            changing = authMode == .changePasscode,
            removing = authMode == .removePasscode
        self.init(recording: recording, changing: changing, removing: removing)
        self.recording = recording
        self.changingPasscode = changing
        self.removingPasscode = removing
    }
    
    convenience init(authMode: AuthMode, presenter: Any) {
        self.init(authMode: authMode)
        self.presenter = presenter
    }
    
    fileprivate convenience init(recording: Bool, changing: Bool, removing: Bool) {
        self.init()
        
        self.recording = recording
        self.changingPasscode = changing
        self.removingPasscode = removing
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if userWantsTouchID && shouldOfferTouchID {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                authenticateWithFingerprint()
            } else {
                shouldOfferTouchID = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        recording = false
        recordingVerification = false
        authString = ""
        authCheckString = ""
        numberOfItemsPressed = 0
    }

    // MARK: - Functions
    func setupViews() {
        
        view.backgroundColor = UIColor.white
        
        (1...passcodeLength).forEach { tag in indicatorViews.append(WBIndicatorView(tag: tag)) }
        (0...9).forEach { identifier in keypadButtons.append(WBKeypadButton(identifier: identifier, autoGenerateSubtext: true)) }
        
        indicatorViews.forEach {
            view.addSubview($0)
            $0.heightAnchor.constraint(equalToConstant: UIConstants.indicatorViewSize).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIConstants.indicatorViewSize).isActive = true
        }
        
        keypadButtons.forEach {
            view.addSubview($0)
            $0.addTarget(self, action: #selector(keypadButtonPressed(_:)), for: .touchUpInside)
            $0.heightAnchor.constraint(equalToConstant: UIConstants.keypadButtonSize).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIConstants.keypadButtonSize).isActive = true
        }
        
        if shouldScrambleButtons { keypadButtons.shuffle() }
        
        indicatorStackView = UIStackView(subviews: indicatorViews)
        view.addSubview(indicatorStackView)
        indicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        let width = (UIConstants.indicatorViewSize * CGFloat(passcodeLength)) + CGFloat(UIConstants.indicatorViewSpacing * CGFloat(passcodeLength - 1))
        indicatorStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        indicatorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let keypadRow1 = UIStackView(subviews: (1...3).map { keypadButtons[$0] }),
            keypadRow2 = UIStackView(subviews: (4...6).map { keypadButtons[$0] }),
            keypadRow3 = UIStackView(subviews: (7...9).map { keypadButtons[$0] }),
            keypadRow4 = UIStackView(subviews: (0...0).map { keypadButtons[$0] })
        
        view.addSubview(keypadRow1)
        keypadRow1.translatesAutoresizingMaskIntoConstraints = false
        keypadRow1.widthAnchor.constraint(equalToConstant: UIConstants.keypadRowWidth).isActive = true
        view.addSubview(keypadRow2)
        keypadRow2.translatesAutoresizingMaskIntoConstraints = false
        keypadRow2.widthAnchor.constraint(equalToConstant: UIConstants.keypadRowWidth).isActive = true
        view.addSubview(keypadRow3)
        keypadRow3.translatesAutoresizingMaskIntoConstraints = false
        keypadRow3.widthAnchor.constraint(equalToConstant: UIConstants.keypadRowWidth).isActive = true
        view.addSubview(keypadRow4)
        keypadRow4.translatesAutoresizingMaskIntoConstraints = false
        
        keypadStackView = UIStackView(arrangedSubviews: [keypadRow1, keypadRow2, keypadRow3, keypadRow4])
        keypadStackView.axis = .vertical
        keypadStackView.alignment = .center
        keypadStackView.distribution = .equalSpacing
        view.addSubview(keypadStackView)
        keypadStackView.translatesAutoresizingMaskIntoConstraints = false
        keypadStackView.heightAnchor.constraint(equalToConstant: UIConstants.keypadSize.height).isActive = true
        
        keypadRow2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        keypadRow2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        indicatorStackView.bottomAnchor.constraint(equalTo: keypadStackView.topAnchor, constant: -50).isActive = true
        
        infoLabel = UILabel()
        infoLabel.text = "Enter Passcode"
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.bottomAnchor.constraint(equalTo: indicatorStackView.topAnchor, constant: -20).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if changingPasscode { infoLabel.text = "Enter Current Passcode" }
    }
    
    func authenticateWithFingerprint() {
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock with Touch ID", reply: { [unowned self]
            (success: Bool, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                if success {
                    self.unwind()
                }
                
                if let authError = error {
                    
                    let laError = LAError(_nsError: authError as NSError)
                    
                    var message = "An error occurred"
                    var shouldDisplayAlert = true
                    
                    switch laError.code {
                    case .authenticationFailed:
                        message = "There was a problem verifying your identity"
                    case .userCancel, .userFallback, .touchIDNotEnrolled:
                        self.context.invalidate()
                        self.shouldOfferTouchID = false
                        shouldDisplayAlert = false
                    default:
                        message = "Touch ID may not be configured"
                    }
                    
                    if shouldDisplayAlert {
                        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        })
    }
    
    func authenticate() {
        
        if authString == keychainWrapper.myObject(forKey: kSecValueData) as? String {
            if !changingPasscode {
                if removingPasscode {
                    keychainWrapper.mySetObject("", forKey: kSecValueData)
                    keychainWrapper.writeToKeychain()
                    UserDefaults.standard.set(false, forKey: DataConstants.UserDefaults.wantsAuthentication.key)
                    UserDefaults.standard.synchronize()
                }
                unwind()
            } else {
                setupForChangePasscode()
            }
        } else {
            failedAuthentication()
        }
    }
    
    func setupForChangePasscode() {
        
        infoLabel.text = "Enter New Passcode"
        authString = ""
        resetIndicatorViews()
        recording = true
        changingPasscode = false
    }
    
    func resetIndicatorViews() {
        
        indicatorViews.forEach { $0.animateUnfill() }
        numberOfItemsPressed = 0
    }
    
    func failedAuthentication() {
        
        infoLabel.text = "Incorrect Passcode"
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        indicatorStackView.shake(DataConstants.Animations.shake.duration, completion: { [unowned self] in
            self.infoLabel.text = "Enter Passcode"
            self.authString = ""
            self.resetIndicatorViews()
        })
    }
    
    func failedRecordingPasscode() {
        
        infoLabel.text = "Passcodes do not match, try again"
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        indicatorStackView.shake(DataConstants.Animations.shake.duration, completion: { [unowned self] in
            self.infoLabel.text = "Enter Passcode"
            self.recordingVerification = false
            self.authString = ""
            self.authCheckString = ""
            self.recording = true
            self.resetIndicatorViews()
        })
    }
    
    func attemptRecordPasscode() {
        
        if authString == authCheckString {
            keychainWrapper.mySetObject(authString, forKey: kSecValueData)
            keychainWrapper.writeToKeychain()
            UserDefaults.standard.set(true, forKey: DataConstants.UserDefaults.wantsAuthentication.key)
            UserDefaults.standard.synchronize()
            unwind()
        } else {
            failedRecordingPasscode()
        }
    }
    
    func resetForVerification() {
        
        infoLabel.text = "Re-enter Passcode"
        recordingVerification = true
        resetIndicatorViews()
    }
    
    func unwind() {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    func keypadButtonPressed(_ sender: WBKeypadButton) {
        
        indicatorViews[numberOfItemsPressed].animateFillIn()
        numberOfItemsPressed += 1
        if !recordingVerification {
            authString += sender.identifier
        } else {
            authCheckString += sender.identifier
        }
        
        if numberOfItemsPressed == passcodeLength {
            if recording == false {
                authenticate()
            } else {
                if recordingVerification {
                    attemptRecordPasscode()
                } else {
                    resetForVerification()
                }
            }
        }
    }
}
