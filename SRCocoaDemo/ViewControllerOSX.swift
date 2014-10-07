//
//  ViewController.swift
//  SRCocoaDemo
//
//  Created by Rick Windham on 9/16/14.
//  Copyright (c) 2014 Swift Time. All rights reserved.
//

import Cocoa
import SwiftlyReachable

class ViewControllerOSX: NSViewController {
    let reachability = STReachability()
    @IBOutlet weak var message: NSTextFieldCell!
    @IBOutlet weak var statusMessage: NSTextFieldCell!
    @IBOutlet weak var methodMessage: NSTextFieldCell!
    @IBOutlet weak var monitorButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateStatus(status:STReachability.STReachabilityStatus) {
        
        switch (status) {
        case (.ViaCellData):
            statusMessage.stringValue = "Reachable"
            methodMessage.stringValue = "CellData"
        case (.ViaWiFi):
            statusMessage.stringValue = "Reachable"
            methodMessage.stringValue = "WiFi"
        default:
            statusMessage.stringValue = "Not Reachable"
            methodMessage.stringValue = "Not Reachable"
        }
        
        message.stringValue = "Binary Flags: \(reachability.binaryFlags)"
    }

    
    @IBAction func checkAction(sendder: AnyObject) {
        updateStatus(reachability.getStatus)
    }
    

    @IBAction func monitorAction(sender: AnyObject) {
        if reachability.monitoring {
            reachability.stopMonitor()
            reachability.changedBlock = nil
            message.stringValue = "Monitor Stopped"
            monitorButton.title = "Monitor is Off"
        } else {
            reachability.changedBlock = {self.updateStatus($0)}
            
            if reachability.startMonitor() {
                message.stringValue = "Monitor Started"
                monitorButton.title = "Monitor is On"
            } else {
                message.stringValue = "Monitor Failed"
                reachability.changedBlock = nil
            }
        }

    }
    
}

