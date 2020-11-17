//
//  ViewController.swift
//  dummy
//
//  Created by robert.t.wan on 10/11/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.pushNotificationReceived = { title, body, params in
                self.label.text = "\(title)\n\n\(body)\n\n\(params)"
            }
        }
    }
}
