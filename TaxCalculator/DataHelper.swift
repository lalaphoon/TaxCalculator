//
//  DataHelper.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-12-28.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation

extension Double {
    func roundTo( places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}