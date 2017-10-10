//
//  DataHelper.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-12-28.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
//reference: https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
//Usuage: let x = Double(0.1234567).rounded(toPlaces:4) // swift 3
