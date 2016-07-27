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
    
    
    var Federal_Bracket = [Int: Float]()
    var Provincial_Bracket = [String : [Int: Float]]()
    
    init() {
        marital_status = ["Married",
                          "Widowed",
                          "Divorced",
                          "Separated",
                          "Single",
                          "Common-Law"]
        
        province_list = ["Ontario",
                         "British Columbia",
                         "Alberta",
                         "Saskatchewan",
                         "Manitoba",
                         "Yukon",
                         "Newfoundland and Labrador",
                         "New Brunswick",
                         "Nova Scotia",
                         "Prince Edward Island",
                         "Nunavut",
                         "Northwest Territories",
                         "Quebec"]
        
        Federal_Bracket = [200000 : 0.33,
                           140388 : 0.29,
                            90563 : 0.26,
                            45282 : 0.205,
                                0 : 0.15
                          ]
        Provincial_Bracket = ["Ontario" : [ 220000 : 0.1316,
                                            150000 : 0.1216,
                                             83075 : 0.1116,
                                             41536 : 0.0915,
                                                 0 : 0.0505
                                          ]
                             ]
    }
    
   

    func getProvinces() -> [String]{
        return province_list
    }
     func getMaritalList() -> [String]{
        return self.marital_status
    }
    
    func flag_a_column(amount : Double , _ collection : [Int : Float]) -> Int {
        //print("The collection dictionary contains \(collection.count) items")
        var counter: Int = collection.count
        for keyCode in collection.keys{
            if Int(amount) > keyCode {
                return counter
            }else {
                counter -= 1
            }
        }
        return 0
    }
    
    func Interest_Calculation(income : Double, _ interest : Double) -> Double {
        var total_1: Double =  income + interest
        print("Total is \(total_1)")
        var top = flag_a_column(total_1, Federal_Bracket)
        print("Top is \(top)")
        var bottom = flag_a_column(income , Federal_Bracket)
        print("bottom is \(bottom)")
        var result = Float()
        
        for var i = top ; i > bottom - 1; --i {
            var level : Double = Double(Array(Federal_Bracket.keys)[Federal_Bracket.count - i])
            if i == bottom {
              //level = income
            result = result + Float((total_1 - income)) * Federal_Bracket[Int(level)]!
            print(result)
            return Double(result)
            }
            
            result = result + Float((total_1 - level)) * Federal_Bracket[Int(level)]!
            total_1 =  Double(level)
        }
        print(result)
        return Double(result)
    }
    
    
}

