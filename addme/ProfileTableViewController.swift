//
//  ProfileTableViewController.swift
//  addme
//
//  Created by Christian Schweig on 16.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import Lock

class ProfileTableViewController: UITableViewController {
    
    @IBAction func onDone(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        let connectionName: String
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            connectionName = "facebook"
        case (0, 1):
            connectionName = "github"
        case (0, 1):
            connectionName = "google"
        case (0, 1):
            connectionName = "instagram"
        case (0, 1):
            connectionName = "microsoft"
        case (0, 1):
            connectionName = "twitter"
        default:
            connectionName = ""
        }
        let lock = A0Lock.sharedLock()
//        let lock = MyApplication.sharedInstance.lock
        lock.identityProviderAuthenticator().authenticateWithConnectionName(connectionName, parameters: nil, success: self.successCallback(), failure: self.errorCallback())
    }
    
    private func errorCallback() -> NSError -> () {
        return { error in
            let alert = UIAlertController(title: "Login failed", message: "Please check you application logs for more info", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: false, completion: nil)
            print("Failed with error \(error)")
        }
    }
    
    private func successCallback() -> (A0UserProfile, A0Token) -> () {
        return { (profile, token) -> Void in
            let alert = UIAlertController(title: "Logged In!", message: "User with name \(profile.name) logged in!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: false, completion: nil)
            print("Logged in user \(profile.name)")
            print("Tokens: \(token)")
        }
    }
    
}
