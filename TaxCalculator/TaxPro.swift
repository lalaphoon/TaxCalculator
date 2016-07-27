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
    
    var FederalBracketDictionary = OrderedDictionary<Int,Float>()
    var ProvincialBracketDictionary =  [String :  OrderedDictionary <Int,Float>] ()
    
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
        FederalBracketDictionary.insert(0.33, forKey: 200000, atIndex: 0)
        FederalBracketDictionary.insert(0.29, forKey: 140388, atIndex: 1)
        FederalBracketDictionary.insert(0.26, forKey: 90563, atIndex: 2)
        FederalBracketDictionary.insert(0.205, forKey: 45282, atIndex: 3)
        FederalBracketDictionary.insert(0.15, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary = ["Ontario" : OrderedDictionary()]
        ProvincialBracketDictionary["Ontario"]?.insert(0.1316, forKey: 220000, atIndex: 0)
        ProvincialBracketDictionary["Ontario"]?.insert(0.1216, forKey: 150000, atIndex: 1)
        ProvincialBracketDictionary["Ontario"]?.insert(0.1116, forKey: 83075, atIndex: 2)
        ProvincialBracketDictionary["Ontario"]?.insert(0.0915, forKey: 41536, atIndex: 3)
        ProvincialBracketDictionary["Ontario"]?.insert(0.0505, forKey: 0, atIndex: 4)
        
        
        
        
        
        
    }
    
   

    func getProvinces() -> [String]{
        return self.province_list
    }
     func getMaritalList() -> [String]{
        return self.marital_status
    }
    //=======================helper =======================================
    /*func flag_a_column(amount : Double , _ collection : [Int : Float]) -> Int {
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
    }*/
    func flag_a_column(amount : Double , _ collection : OrderedDictionary<Int, Float>) -> Int {
        //print("The collection dictionary contains \(collection.count) items")
        var counter: Int = collection.count
        for var i = 0 ; i < counter; ++i {
            var byIndex: (Int, Float) = collection[i]
            if Int(amount) > byIndex.0 {
               // print("amount is \(amount)")
               // print("keycode is \(byIndex.0)")
               // print(counter - i)
                return counter - i
            }
        }
        return 0
        
    }
    /*
    func calculateTheDifference(income: Double, _ total : Double, _ group : [Int : Float]) -> Double{
        var top = flag_a_column(total, group)
        //print("Top is \(top)")
        var bottom = flag_a_column(income , group)
        //print("bottom is \(bottom)")
        var result = Float()
        var total_container : Double = total
        for var i = top ; i > bottom - 1; --i {
        var level : Double = Double(Array(group.keys)[group.count - i])
            if i == bottom {
                //level = income
                result = result + Float((total_container - income)) * group[Int(level)]!
                //print("where am i? \(result)")
                return Double(result)
            }
            result = result + Float((total_container - level)) * group[Int(level)]!
            total_container =  Double(level)
        }
        return Double(result)

    }*/
    func calculateTheDifference(income: Double, _ total : Double, _ group : OrderedDictionary<Int , Float>) -> Double{
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
        var top = flag_a_column(total_1, FederalBracketDictionary)
        var bottom = flag_a_column(income, FederalBracketDictionary)
        //print("Top is \(top) and bottom is \(bottom)")
        /*var top = flag_a_column(total_1, Federal_Bracket)
        var bottom = flag_a_column(income , Federal_Bracket)
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
        print(result
        return Double(result)*/
        //print(Federal_Bracket)
       // print(Provincial_Bracket["Ontario"])
        print(Float(calculateTheDifference(income, total_1, FederalBracketDictionary)))
       // print("error is that dictionary is not in ordered")
        //let sortedarray =  Provincial_Bracket["Ontario"].sort
        //print(Float(calculateTheDifference(income, total_1, Provincial_Bracket["Ontario"]!.sort{$0.0 > $1.0})))
        print(Float(calculateTheDifference(income, total_1, ProvincialBracketDictionary["Ontario"]!)))
        return calculateTheDifference(income, total_1, FederalBracketDictionary)
        
    }
    
    
}

