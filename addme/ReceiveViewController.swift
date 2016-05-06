//
//  ReceiveViewController.swift
//  addme
//
//  Created by Christian Schweig on 17.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import MTBBarcodeScanner

class ReceiveViewController: UIViewController {

    @IBOutlet weak var scanview: UIView!
    
    var scanner: MTBBarcodeScanner!
    var scan: String!
    
    override func viewDidLoad() {
        self.scanner = MTBBarcodeScanner.init(metadataObjectTypes: [AVMetadataObjectTypeQRCode], previewView: scanview)
    }
    
    override func viewWillAppear(animated: Bool) {
        MTBBarcodeScanner.requestCameraPermissionWithSuccess { (success) -> Void in
            if (success) {
                self.scanner.startScanningWithResultBlock { (codes) -> Void in
                    for code in codes {
                        self.scan = code.stringValue
                        print(self.scan)
                    }
                    self.scanner.stopScanning()
                    self.performSegueWithIdentifier("received", sender: nil)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "received" {
            let svc = segue.destinationViewController.childViewControllers[0] as! NewContactTableViewController
            svc.scan = self.scan
        }
    }

}
