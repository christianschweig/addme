//
//  ProfileTableViewController.swift
//  addme
//
//  Created by Christian Schweig on 16.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import Lock
import SimpleKeychain
//import Auth0

class ProfileTableViewController: UITableViewController {
    
    var strategies = [A0Strategy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        A0Lock.shared().apiClient().fetchAppInfo(success: { (application) in
            self.strategies = application.socialStrategies as! [A0Strategy]
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.strategies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let strategy: A0Strategy = self.strategies[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SocialCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = strategy.name
        cell.detailTextLabel?.text = "not connected"
        cell.imageView?.image = UIImage(named: strategy.name)
        return cell
    }
    
    @IBAction func onDone(_ sender: AnyObject) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterStrategy",
            let nextScene = segue.destination as? StrategyTableViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedStrategy = self.strategies[indexPath.row]
                nextScene.strategy = selectedStrategy
            }
     }
    
}
