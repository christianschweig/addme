//
//  WelcomeViewController.swift
//  addme
//
//  Created by Christian Schweig on 26.07.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import Lock

class WelcomeViewController: UIViewController {
    
    @IBAction func onEnter(sender: AnyObject) {
        let lock = MyApplication.sharedInstance.lock
        let controller = lock.newEmailViewController()
        controller.useMagicLink = true
        controller.onAuthenticationBlock = { (profile, token) in
            let app = MyApplication.sharedInstance
            app.token = token
            app.profile = profile
            self.dismissViewControllerAnimated(true, completion: { self.performSegueWithIdentifier("UserLoggedIn", sender: self) })
        }
        lock.presentEmailController(controller, fromController: self)
    }

}