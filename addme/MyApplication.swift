//
//  MyApplication.swift
//  addme
//
//  Created by Christian Schweig on 25.07.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import Foundation
import Lock

class MyApplication {
    
    static var sharedInstance = MyApplication()
    
    var lock = A0Lock()
    var profile: A0UserProfile?
    var token: A0Token?
    var nonSecurePingURL: NSURL
    var securePingURL: NSURL
//    var keychain: A0SimpleKeychain
    
    private init() {
        let urlString = NSBundle.mainBundle().infoDictionary?["Auth0SampleURL"] as? String ?? "http://localhost:3001"
        let baseURL = NSURL(string: urlString)
        self.nonSecurePingURL = NSURL(string: "/ping", relativeToURL: baseURL)!
        self.securePingURL = NSURL(string: "/secured/ping", relativeToURL: baseURL)!
//        keychain = A0SimpleKeychain(service: "Auth0")
//        lock = A0Lock.newLock()
//        let facebook = A0FacebookAuthenticator.newAuthenticatorWithDefaultPermissions()
//        let twitterApiKey = "ffdsfs" //Remember to obfuscate your api key
//        let twitterApiSecret = "ffdsfs" //Remember to obfuscate your api key
//        let twitter = A0TwitterAuthenticator.newAuthenticatorWithKey(twitterApiKey, andSecret: twitterApiSecret)
        //lock.registerAuthenticators([email])
    }
}