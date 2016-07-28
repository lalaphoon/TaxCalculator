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
    
    var FederalBracketDictionary = OrderedDictionary<Int,Float>()
    var ProvincialBracketDictionary =  [String :  OrderedDictionary <Int,Float>] ()
    
    var InterestThreshold = [Int: Float]()
    
    init() {
        initLists()
        initBracket()
    }
    
    func initLists() {
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
    }
    func initBracket() {
        //================Interest/income calculation===============================
        FederalBracketDictionary.insert(0.33, forKey: 200000, atIndex: 0)
        FederalBracketDictionary.insert(0.29, forKey: 140388, atIndex: 1)
        FederalBracketDictionary.insert(0.26, forKey: 90563, atIndex: 2)
        FederalBracketDictionary.insert(0.205, forKey: 45282, atIndex: 3)
        FederalBracketDictionary.insert(0.15, forKey: 0, atIndex: 4)
        
        //Init provincial bracket
        ProvincialBracketDictionary = ["Ontario" : OrderedDictionary()]
        ProvincialBracketDictionary["Ontario"]?.insert(0.1316, forKey: 220000, atIndex: 0)
        ProvincialBracketDictionary["Ontario"]?.insert(0.1216, forKey: 150000, atIndex: 1)
        ProvincialBracketDictionary["Ontario"]?.insert(0.1116, forKey: 83075, atIndex: 2)
        ProvincialBracketDictionary["Ontario"]?.insert(0.0915, forKey: 41536, atIndex: 3)
        ProvincialBracketDictionary["Ontario"]?.insert(0.0505, forKey: 0, atIndex: 4)
    
        InterestThreshold = [73145 : 0.2 , 86176: 0.36]
        //===========================================================================
    }
   

    func getProvinces() -> [String]{
        return self.province_list
    }
     func getMaritalList() -> [String]{
        return self.marital_status
    }
    //=======================helper =======================================
    
    func flag_a_column(amount : Double , _ collection : OrderedDictionary<Int, Float>) -> Int {
        var counter: Int = collection.count
        for var i = 0 ; i < counter; ++i {
            var byIndex: (Int, Float) = collection[i]
            if Int(amount) > byIndex.0 {
                return counter - i
            }
        }
        return 0
        
    }
  
    func calculateTheDifference(income: Double, _ total : Double, _ group : OrderedDictionary<Int , Float>) -> Double{
        
        if total < income {
            return 0
        }
        
        var top = flag_a_column(total, group)
       // print("Top is \(top)")
        var bottom = flag_a_column(income , group)
        //print("bottom is \(bottom)")
        var result = Float()
        var total_container : Double = total
        for var i = top ; i > bottom - 1; --i {
            var byIndex: (Int, Float) = group[group.count - i]
            var level : Double = Double(byIndex.0)
           // print("level is \(level)")
            var byKey: Float = group[Int(level)]!
            if i == bottom {
                //level = income
                
                result = result + Float((total_container - income)) * byKey
                //print("where am i? \(result)")
                return Double(result)
            }
            result = result + Float((total_container - level)) * byKey
            total_container =  Double(level)
        }
        return Double(result)
        
    }
    
    //=====================helper end=======================================
    
    func Interest_Calculation(income : Double, _ interest : Double) -> Double {
        var total_1: Double =  income + interest
        
        var result = Float(0)
       
        //Step 1
        print(Float(calculateTheDifference(income, total_1, FederalBracketDictionary)))
        result = result + Float(calculateTheDifference(income, total_1, FederalBracketDictionary))
        //Step 2
        print(Float(calculateTheDifference(income, total_1, ProvincialBracketDictionary["Ontario"]!)))
        result = result + Float(calculateTheDifference(income, total_1, ProvincialBracketDictionary["Ontario"]!))
        
        /*//Step 3
        
        if income < 73145 {
            print(Float(calculateTheDifference(73145, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[73145]!)
        } else {
            print(Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[73145]!)
        }
        //Step 4
        if income < 86176 {
            print(Float(calculateTheDifference(86176, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[86176]!)
        } else {
            print(Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[86176]!)
        }*/
        
        
        
        //Step 3 & 4
        for keyCode in InterestThreshold.keys {
            if income < Double(keyCode) {
                print(Float(calculateTheDifference(Double(keyCode), total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[keyCode]!)
                result = result + Float(calculateTheDifference(Double(keyCode), total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[keyCode]!
            } else {
                print(Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[keyCode]!)
                result = result + Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[keyCode]!
            }
        }
        
        print(result)
        return Double(result)
        
    }
    
    
}

