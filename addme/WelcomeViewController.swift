//
//  WelcomeViewController.swift
//  addme
//
//  Created by Christian Schweig on 26.07.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import Lock
import SimpleKeychain

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        print("Welcome")
        let keychain = A0SimpleKeychain(service: "Auth0")
        guard let idToken = keychain.string(forKey: "id_token") else {
            let lock = A0Lock.shared()
            let controller = lock.newEmailViewController()
            controller?.useMagicLink = true
            controller?.onAuthenticationBlock = { (profile, token) in
                let profile = profile
                let token = token
                keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                keychain.setString(token.idToken, forKey: "id_token")
                keychain.setString(token.refreshToken!, forKey: "refresh_token")
                self.dismiss(animated: true, completion: { self.performSegue(withIdentifier: "UserLoggedIn", sender: self) })
            }
            lock.presentEmailController(controller, from: self)
            return
        }
        let client = A0Lock.shared().apiClient()
        client.fetchUserProfile(
            withIdToken: idToken,
            success: { profile in
                let profile = profile
                keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                self.performSegue(withIdentifier: "UserLoggedIn", sender: self)
            },
            failure: { error in
                // idToken has expired or is no longer valid
                guard let refreshToken = keychain.string(forKey: "refresh_token") else {
                    keychain.clearAll()
                    return
                }
                let client = A0Lock.shared().apiClient()
                client.fetchNewIdToken(
                    withRefreshToken: refreshToken,
                    parameters: nil,
                    success: { newToken in
                        keychain.setString(newToken.idToken, forKey: "id_token")
                        self.performSegue(withIdentifier: "UserLoggedIn", sender: self)
                    },
                    failure: { error in
                        keychain.clearAll()
                        return
                })
            }
        )
    }
    
}
