//
//  GlobalVariables.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-23.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
class TaxPro {
    
    var province_list : [String] = []
    var marital_status : [String] = []
    init() {
        marital_status = ["Married", "Widowed", "Divorced", "Separated", "Single", "Common-Law"]
        province_list = ["Ontario", "British Columbia", "Alberta", "Saskatchewan", "Manitoba", "Yukon", "Newfoundland and Labrador", "New Brunswick", "Nova Scotia", "Prince Edward Island", "Nunavut", "Northwest Territories", "Quebec"]
    }

    func getProvinces() -> [String]{
      
        return province_list
    }
     func getMaritalList() -> [String]{
        return self.marital_status
    }
    
}

