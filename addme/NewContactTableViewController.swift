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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookCell", for: indexPath)
        
        // Configure the cell...

        return cell
    }
    
    @IBAction func onFbAdd(_ sender: AnyObject) {
        print("add")
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
