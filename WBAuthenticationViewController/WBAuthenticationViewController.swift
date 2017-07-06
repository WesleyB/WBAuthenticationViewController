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
    
    fileprivate lazy var context = LAContext()
    fileprivate var keychainWrapper = KeychainWrapper()
    
    fileprivate var shouldOfferTouchID : Bool = true
    fileprivate var recording : Bool = false
    fileprivate var recordingSecondPass : Bool = false
    fileprivate var changingPasscode : Bool = false
    fileprivate var removingPasscode : Bool = false
    
    fileprivate var numberOfItemsPressed : Int = 0
    fileprivate var authString = ""
    fileprivate var authCheckString = ""
    
    // MARK: - Initializers
    convenience init(recording: Bool, changing: Bool, removing: Bool) {
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

    // MARK: - Functions
    func setupViews() {
        
        (1...4).forEach { tag in indicatorViews.append(WBIndicatorView(tag: tag)) }
        (0...9).forEach { identifier in keypadButtons.append(WBKeypadButton(identifier: identifier)) }
        
        indicatorViews.forEach {
            view.addSubview($0)
            $0.heightAnchor.constraint(equalToConstant: ViewDimensions.view.indicatorView.dimension).isActive = true
            $0.widthAnchor.constraint(equalToConstant: ViewDimensions.view.indicatorView.dimension).isActive = true
        }
        
        keypadButtons.forEach {
            view.addSubview($0)
            $0.addTarget(self, action: #selector(keypadButtonPressed(_:)), for: .touchUpInside)
            $0.heightAnchor.constraint(equalToConstant: ViewDimensions.view.keypadButton.dimension).isActive = true
            $0.widthAnchor.constraint(equalToConstant: ViewDimensions.view.keypadButton.dimension).isActive = true
        }
        
        indicatorStackView = UIStackView(subviews: indicatorViews)
        view.addSubview(indicatorStackView)
        indicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        indicatorStackView.widthAnchor.constraint(equalToConstant: ViewDimensions.view.indicatorStackView.width).isActive = true
        indicatorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let keypadRow1 = UIStackView(subviews: (1...3).map { keypadButtons[$0] }),
            keypadRow2 = UIStackView(subviews: (4...6).map { keypadButtons[$0] }),
            keypadRow3 = UIStackView(subviews: (7...9).map { keypadButtons[$0] }),
            keypadRow4 = UIStackView(subviews: (0...0).map { keypadButtons[$0] })
        
        view.addSubview(keypadRow1)
        keypadRow1.translatesAutoresizingMaskIntoConstraints = false
        keypadRow1.widthAnchor.constraint(equalToConstant: ViewDimensions.view.keypadRow.width).isActive = true
        view.addSubview(keypadRow2)
        keypadRow2.translatesAutoresizingMaskIntoConstraints = false
        keypadRow2.widthAnchor.constraint(equalToConstant: ViewDimensions.view.keypadRow.width).isActive = true
        view.addSubview(keypadRow3)
        keypadRow3.translatesAutoresizingMaskIntoConstraints = false
        keypadRow3.widthAnchor.constraint(equalToConstant: ViewDimensions.view.keypadRow.width).isActive = true
        view.addSubview(keypadRow4)
        keypadRow4.translatesAutoresizingMaskIntoConstraints = false
        
        keypadStackView = UIStackView(arrangedSubviews: [keypadRow1, keypadRow2, keypadRow3, keypadRow4])
        keypadStackView.axis = .vertical
        keypadStackView.alignment = .center
        keypadStackView.distribution = .equalSpacing
        view.addSubview(keypadStackView)
        keypadStackView.translatesAutoresizingMaskIntoConstraints = false
        keypadStackView.heightAnchor.constraint(equalToConstant: ViewDimensions.view.keypadStackView.height).isActive = true
        
        keypadRow2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        keypadRow2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        indicatorStackView.bottomAnchor.constraint(equalTo: keypadStackView.topAnchor, constant: -50).isActive = true
        
        infoLabel = UILabel()
        infoLabel.text = "Enter Passcode"
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.bottomAnchor.constraint(equalTo: indicatorStackView.topAnchor, constant: -10).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    func keypadButtonPressed(_ sender: WBKeypadButton) {
        
        
    }
}

struct ViewDimensions {
    
    enum view {
        case keypadButton
        case indicatorView
        case indicatorStackView
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
            case .indicatorStackView: return UIScreen.main.bounds.width/2.93
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




















