//
//  NewContactTableViewController.swift
//  addme
//
//  Created by Christian Schweig on 17.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit

class NewContactTableViewController: UITableViewController {

    var scan: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FacebookCell", forIndexPath: indexPath)
        
        // Configure the cell...

        return cell
    }
    
    @IBAction func onFbAdd(sender: AnyObject) {
        print("add")
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
