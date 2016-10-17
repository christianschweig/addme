//
//  StrategyTableViewController.swift
//  addme
//
//  Created by Christian Schweig on 15.10.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import Lock
import Auth0
import SimpleKeychain

class StrategyTableViewController: UITableViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var strategy = A0Strategy()
    var identity = A0UserIdentity()

    override func viewDidLoad() {
        self.navigationItem.title = self.strategy.name
        let keychain = A0SimpleKeychain(service: "Auth0")
        guard let idToken = keychain.string(forKey: "id_token") else {
            // Present A0Lock Login
            return
        }
        let client = A0Lock.shared().apiClient()
        client.fetchUserProfile(withIdToken: idToken, success: { (profile) in
            let identities = profile.identities as! [A0UserIdentity]
            print(identities)
            self.user.text = "not connected"
            self.button.setTitle("Link", for: .normal)
            self.button.removeTarget(self, action: #selector(self.onUnlink), for: .touchUpInside)
            self.button.addTarget(self, action: #selector(self.onLink), for: .touchUpInside)
            for i: A0UserIdentity in identities {
                if i.provider == self.strategy.name {
                    //image anzeigen
                    //FIXME Bug with github (integer statt string)
                    self.identity = i
                    self.user.text = i.userId
                    self.button.setTitle("Unlink", for: .normal)
                    self.button.removeTarget(self, action: #selector(self.onLink), for: .touchUpInside)
                    self.button.addTarget(self, action: #selector(self.onUnlink), for: .touchUpInside)
                    break
                }
            }
            }) { (error) in
                print(error)
        }
        print(self.strategy)
    }

    func onLink(sender: UIButton!) {
        print("Link")
        A0Lock.shared().identityProviderAuthenticator().authenticate(withConnectionName: self.strategy.name, parameters: nil, success: self.successCallback()) { (error) in
            print(error)
        }
    }
    
    fileprivate func successCallback() -> (A0UserProfile, A0Token) -> () {
        return { (otherProfile, otherToken) -> Void in
            print(otherProfile)
            print(otherToken)
            let keychain = A0SimpleKeychain(service: "Auth0")
            guard let idToken = keychain.string(forKey: "id_token") else {
                // Present A0Lock Login
                return
            }
            let client = A0Lock.shared().apiClient()
            client.fetchUserProfile(withIdToken: idToken, success: { (profile) in
                let profile = profile
                Auth0.users(token: idToken).link(profile.userId, withOtherUserToken: otherToken.idToken)
                    .start({ result in
                        switch result {
                            case .success:
                                print("linked")
                            case .failure(let error):
                                print(error)
                        }
                })
            }) { (error) in
                print(error)
            }

        }
    }
    
    func onUnlink(sender: UIButton!) {
        print("Unlink")
        let keychain = A0SimpleKeychain(service: "Auth0")
        guard let idToken = keychain.string(forKey: "id_token") else {
            // Present A0Lock Login
            return
        }
        let client = A0Lock.shared().apiClient()
        client.fetchUserProfile(withIdToken: idToken, success: { (profile) in
            let profile = profile
            Auth0.users(token: idToken).unlink(identityId: self.identity.userId, provider: self.identity.provider, fromUserId: profile.userId).start({ (result) in
                switch result {
                    case .success: //.success(let cred):
                        print("unlinked")
                    case .failure(error: let error): //.failure(let error):
                        print(error)
                }
            })
            }) { (error) in
                print(error)
        }
    }
    
//    fileprivate func errorCallback() -> (NSError) -> () {
//        return { error in
//            let alert = UIAlertController(title: "Login failed", message: "Please check you application logs for more info", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: false, completion: nil)
//            print("Failed with error \(error)")
//        }
//    }

}
