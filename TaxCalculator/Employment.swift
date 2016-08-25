//
//  Employment.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-22.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit
/*
class Employment: Formula {
    var TP = TaxPro()
    var category: Category = Category.Income
    var name: String = "Employment"
    var description: String {return name}
    var income: Double
    var total: Double
    var province: String
    init (income: Double, _ total: Double, _ Province: String){
        self.income = income
        self.total = total
        self.province = Province
    }
    
    func stepOne() -> Double{
        return TP.calculateTheDifference(income, total, TP.FederalBracketDictionary)
    }
    func stepTwo() -> Double {
        return TP.calculateTheDifference(income, total, TP.ProvincialBracketDictionary[self.province]!)
    }
    func stepThree() -> Double{
        let boundry: Double = 73145
        if self.income < boundry {
         
            return TP.calculateTheDifference(boundry, total,TP.ProvincialBracketDictionary[self.province]! )  * TP.InterestThreshold[Int(boundry)]!
        } else {
           return TP.calculateTheDifference(income, total,TP.ProvincialBracketDictionary[self.province]! )  * TP.InterestThreshold[Int(boundry)]!
        }
        
    }
    func stepFour() -> Double{
        let boundry: Double = 86176
        if self.income < boundry {
            
            return TP.calculateTheDifference(boundry, total,TP.ProvincialBracketDictionary[self.province]! )  * TP.InterestThreshold[Int(boundry)]!
        } else {
            return TP.calculateTheDifference(income, total,TP.ProvincialBracketDictionary[self.province]! )  * TP.InterestThreshold[Int(boundry)]!
        }
    
    }
    func getResult() -> Double {
        return stepOne() + stepTwo() + stepThree() + stepFour()
    }
    func getTip() -> String {
        return ""
    }
    func displayResult() {
     //do something
    }
    
   
}*/

/*class Employment_Income: Formula {
    
}*/





