//
//  ViewController.swift
//  SRDemoApp
//
//  Created by Rick Windham on 9/4/14.
//  Copyright (c) 2014 Swift Time. All rights reserved.
//

import UIKit
import SwiftlyReachable

class ViewControlleriOS: UIViewController {
    
    @IBOutlet weak var reachableLabel: UILabel!
    @IBOutlet weak var wwanLabel: UILabel!
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var monitorUIButton: UIButton!
    
    var reachability:STReachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reachability = STReachability() // init with apple.com
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func monitorAction(sender: AnyObject) {
        if reachability.monitoring {
            reachability.stopMonitor()
            reachability.changedBlock = nil
            binaryLabel.text = "Monitor Stopped"
            monitorUIButton.setTitle("Start", forState: .Normal)
        } else {
            reachability.changedBlock = {self.updateStatus($0)}
            
            if reachability.startMonitor() {
                binaryLabel.text = "Monitor Started"
            monitorUIButton.setTitle("Stop", forState: .Normal)
            } else {
                binaryLabel.text = "Monitor Failed"
                reachability.changedBlock = nil
            }
        }
    }
    
    func updateStatus(status:STReachability.STReachabilityStatus) {
        
        switch (status) {
        case (.ViaCellData):
            reachableLabel.text = "Yes"
            wwanLabel.text = "Cell"
        case (.ViaWiFi):
            reachableLabel.text = "Yes"
            wwanLabel.text = "WiFi"
        default:
            reachableLabel.text = "No"
            wwanLabel.text = ""
        }
        
        binaryLabel.text = reachability.binaryFlags
    }
    
    
    @IBAction func checkReacability(sender: AnyObject) {
        updateStatus(reachability.getStatus)
    }
}

