//
//  SendViewController.swift
//  addme
//
//  Created by Christian Schweig on 18.03.16.
//  Copyright © 2016 christianschweig. All rights reserved.
//

import UIKit
import QRCode

class SendViewController: UIViewController {

    @IBOutlet weak var qrcodeview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onQR(_ sender: AnyObject) {
        /*if (FBSDKAccessToken.currentAccessToken() != nil) {
            let request = FBSDKGraphRequest.init(graphPath: "me", parameters: nil)
            request.startWithCompletionHandler({ (connection, result, error) -> Void in
                if ((error == nil)) {
                    print(result)
                    let id = result["id"] as! String
                    //let username = result["name"] as! String

                    /*let fbDic: [String:String] = [
                        "service": "facebook",
                        "id": id
                    ]
                    let fbData : NSData = NSKeyedArchiver.archivedDataWithRootObject(fbDic)*/
                    //let dictionary: [String:String] = NSKeyedUnarchiver.unarchiveObjectWithData(dataExample)! as! Dictionary
                                        
                    let qrCode = QRCode(id)
                    self.qrcodeview.image = qrCode!.image
                }
            })
        }*/
    }
    
    
}
