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
    class func delay(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
}
