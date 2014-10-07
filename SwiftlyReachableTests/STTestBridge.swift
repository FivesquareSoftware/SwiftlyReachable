//
//  STTestBridge.swift
//  SwiftlyReachable
//
//  Created by Rick Windham on 9/6/14.
//  Copyright (c) 2014 Swift Time. All rights reserved.
//
//  mock class for testing STReachability.swift

import Foundation
import SystemConfiguration

typealias changeBlock = ((UInt32) -> Void)

class STReachabilityBridge {
    var monitoring:Bool = false
    var target:SCNetworkReachability!
    var block:changeBlock!
    
    init(target:SCNetworkReachability, andBlock block:changeBlock) {
        println("statusFlags \(statusFlags)")
        self.block = block
    }
    
    deinit {
        println("*** bridge de-init ***")
    }
    
    func startMonitoring() -> Bool {
        dispatch_async(dispatch_get_main_queue()) {self.block(statusFlags)}
        
        return true
    }
    
    func stopMonitoring() {
        monitoring = false
    }
    
    func getStatus() -> UInt32 {
        return statusFlags
    }
}
