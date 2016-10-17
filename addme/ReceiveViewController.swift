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
    
    override func viewWillAppear(_ animated: Bool) {
        MTBBarcodeScanner.requestCameraPermission { (success) -> Void in
            if (success) {
                self.scanner.startScanning(resultBlock: { (codes) in
                    for code in codes! {
                        self.scan = (code as AnyObject).stringValue
                        print(self.scan)
                    }
                    self.scanner.stopScanning()
                    self.performSegue(withIdentifier: "received", sender: nil)
                    }, error: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "received" {
            let svc = segue.destination.childViewControllers[0] as! NewContactTableViewController
            svc.scan = self.scan
        }
    }

}
