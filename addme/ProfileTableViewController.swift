//
//  ProfileTableViewController.swift
//  addme
//
//  Created by Christian Schweig on 16.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBAction func onDone(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
