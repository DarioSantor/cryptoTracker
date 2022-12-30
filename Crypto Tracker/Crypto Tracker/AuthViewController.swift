//
//  AuthViewController.swift
//  Crypto Tracker
//
//  Created by Santos, Dario Ferreira on 30/12/2022.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        presentAuth()
    }
    
    func presentAuth() {
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Your crypto is protected by biometrics") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    let cryptoTableVC = CryptoTableViewController()
                    let navController = UINavigationController(rootViewController: cryptoTableVC)
                    self.present(navController, animated: true, completion: nil)
                }
            } else {
                self.presentAuth()
            }
        }
    }
    
}
