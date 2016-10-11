//
//  HelperLibrary.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation

class HelperLibrary {
    
    // helper function to delay whatever's in the callback
    class func delay(seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
}