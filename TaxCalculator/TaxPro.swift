//
//  GlobalVariables.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-23.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
enum Location: String {
    case Ontario = "Ontario"
    case British_Columbia = "British Columbia"
    case Alberta = "Alberta"
    case Saskatchewan = "Saskatchewan"
    case Manitoba = "Manitoba"
    case Yukon = "Yukon"
    case Newfoundl_and_AndLabrador = "Newfoundland and Labrador"
    case New_Brunswick = "New Brunswick"
    case Nova_Scotia = "Nova Scotia"
    case Prince_Edward_Island = "Prince Edward Island"
    case Nunavut = "Nunavut"
    case Northwest_Territories = "Northwest Territories"
    case Quebec = "Quebec"
    case Federal = "Federal"
}

class TaxPro {
    
    var province_list : [String] = []
    var marital_status : [String] = []
    
    var FederalBracketDictionary = OrderedDictionary<Int,Double>()
    var ProvincialBracketDictionary =  [Location :  OrderedDictionary <Int,Double>] ()
    
    var InterestThreshold = OrderedDictionary<Int, Double>()
    
    var TaxCredit =  [Location : Double]()
    var EligibleDividendTaxCredit = [Location: Double]()
    var Non_EligibleDividendTaxCredit = [Location: Double]()
    
    var BasicPersonalAmount = [Location : Double]()
    
    var BasicReduction = [Location: Double]()
    //TODO: Fill in Provincial Tax
    var ProvincialCredit = [Location: Double]()
    var HealthPremium = [Location : OrderedDictionary <Int, Double>]()
    
    init() {
        initLists()
        initBracket()
        initTaxCredit()
        initBasicPersonalAmount()
        initBasicReduction()
    }
    
    func initLists() {
        marital_status = ["Married",
            "Widowed",
            "Divorced",
            "Separated",
            "Single",
            "Common-Law"]
        
        province_list = [
            Location.Ontario.rawValue ,
            Location.British_Columbia.rawValue,
            Location.Alberta.rawValue ,
            Location.Saskatchewan.rawValue,
            Location.Manitoba.rawValue,
            Location.Yukon.rawValue,
            Location.Newfoundl_and_AndLabrador.rawValue,
            Location.New_Brunswick.rawValue,
            Location.Nova_Scotia.rawValue,
            Location.Prince_Edward_Island.rawValue,
            Location.Nunavut.rawValue,
            Location.Northwest_Territories.rawValue,
            Location.Quebec.rawValue]
    }
    func initTaxCredit(){
        TaxCredit = [Location.Federal: 0.15 , Location.Ontario: 0.0505, Location.Alberta : 0.10 , Location.British_Columbia : 0.0506, Location.Manitoba : 0.108, Location.Saskatchewan : 0.11, Location.Yukon: 0.064, Location.New_Brunswick : 0.0968, Location.Nova_Scotia: 0.0879, Location.Sasketchewan: 0.11]
        EligibleDividendTaxCredit = [Location.Federal: 0.1502,
            Location.Ontario: 0.1,
            Location.Saskatchewan: 0.11,
            Location.British_Columbia: 0.1,
            Location.Manitoba: 0.08,
            Location.Alberta : 0.1,
            Location.Yukon: 0.15,
            Location.New_Brunswick : 0.12,
            Location.Nova_Scotia : 0.0885,
            Location.Saskatchewan: o.11]
        Non_EligibleDividendTaxCredit = [Location.Federal: 0.105217,
            Location.Ontario: 0.042863,
            Location.Saskatchewan: 0.03367,
            Location.British_Columbia: 0.0247,
            Location.Manitoba: 0.0083,
            Location.Alberta : 0.0308,
            Location.Yukon : 0.0314,
            Location.New_Brunswick :0.04,
            Location.Nova_Scotia: 0.0333,
            Location.Saskatchewan: 0.03367]
        
    }
    func initBracket() {
        //================Interest/income calculation===============================
        FederalBracketDictionary.insert(0.33, forKey: 200000, atIndex: 0)
        FederalBracketDictionary.insert(0.29, forKey: 140388, atIndex: 1)
        FederalBracketDictionary.insert(0.26, forKey: 90563, atIndex: 2)
        FederalBracketDictionary.insert(0.205, forKey: 45282, atIndex: 3)
        FederalBracketDictionary.insert(0.15, forKey: 0, atIndex: 4)
        
        //Init provincial bracket
        ProvincialBracketDictionary = [Location.Ontario : OrderedDictionary(),
                                       Location.Alberta : OrderedDictionary(),
                                       Location.British_Columbia: OrderedDictionary(),
                                       Location.Manitoba: OrderedDictionary(),
                                       Location.Saskatchewan : OrderedDictionary(),
                                       Location.Yukon : OrderedDictionary(),
                                       Location.New_Brunswick : OrderedDictionary(),
                                       Location.Nova_Scotia : OrderedDictionary(),
                                        Location.Saskatchewan : OrderedDictionary()]
        ProvincialBracketDictionary[Location.Ontario]?.insert(0.1316, forKey: 220000, atIndex: 0)
        ProvincialBracketDictionary[Location.Ontario]?.insert(0.1216, forKey: 150000, atIndex: 1)
        ProvincialBracketDictionary[Location.Ontario]?.insert(0.1116, forKey: 83075, atIndex: 2)
        ProvincialBracketDictionary[Location.Ontario]?.insert(0.0915, forKey: 41536, atIndex: 3)
        ProvincialBracketDictionary[Location.Ontario]?.insert(0.0505, forKey: 0, atIndex: 4)
        
        
        ProvincialBracketDictionary[Location.Alberta]?.insert(0.15, forKey: 300000, atIndex: 0)
        ProvincialBracketDictionary[Location.Alberta]?.insert(0.14, forKey: 200000, atIndex: 1)
        ProvincialBracketDictionary[Location.Alberta]?.insert(0.13, forKey: 150000, atIndex: 2)
        ProvincialBracketDictionary[Location.Alberta]?.insert(0.12, forKey: 125000, atIndex: 3)
        ProvincialBracketDictionary[Location.Alberta]?.insert(0.10, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary[Location.British_Columbia]?.insert(0.1470, forKey: 106543, atIndex: 0)
        ProvincialBracketDictionary[Location.British_Columbia]?.insert(0.1229, forKey: 87741, atIndex: 1)
        ProvincialBracketDictionary[Location.British_Columbia]?.insert(0.1050, forKey: 76421, atIndex: 2)
        ProvincialBracketDictionary[Location.British_Columbia]?.insert(0.0770, forKey: 38210, atIndex: 3)
        ProvincialBracketDictionary[Location.British_Columbia]?.insert(0.0506, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary[Location.Manitoba]?.insert(0.1740, forKey: 67000, atIndex: 0)
        ProvincialBracketDictionary[Location.Manitoba]?.insert(0.1275, forKey: 31000, atIndex: 1)
        ProvincialBracketDictionary[Location.Manitoba]?.insert(0.1080, forKey: 0, atIndex: 2)
        
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.15, forKey: 127430, atIndex: 0)
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.13, forKey: 44601, atIndex: 1)
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.11, forKey: 0, atIndex: 2)
        
        ProvincialBracketDictionary[Location.Yukon]?.insert(0.15, forKey: 500000, atIndex: 0)
        ProvincialBracketDictionary[Location.Yukon]?.insert(0.128, forKey: 140388, atIndex: 1)
        ProvincialBracketDictionary[Location.Yukon]?.insert(0.109, forKey: 90563, atIndex: 2)
        ProvincialBracketDictionary[Location.Yukon]?.insert(0.09, forKey: 45282, atIndex: 3)
        ProvincialBracketDictionary[Location.Yukon]?.insert(0.064, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary[Location.New_Brunswick]?.insert(0.203, forKey: 150000, atIndex: 0)
        ProvincialBracketDictionary[Location.New_Brunswick]?.insert(0.1784, forKey: 131664, atIndex: 1)
        ProvincialBracketDictionary[Location.New_Brunswick]?.insert(0.1652, forKey: 80985, atIndex: 2)
        ProvincialBracketDictionary[Location.New_Brunswick]?.insert(0.1482, forKey: 40492, atIndex: 3)
        ProvincialBracketDictionary[Location.New_Brunswick]?.insert(0.0968, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary[Location.Nova_Scotia]?.insert(0.21, forKey: 150000, atIndex: 0)
        ProvincialBracketDictionary[Location.Nova_Scotia]?.insert(0.175, forKey: 93000, atIndex: 1)
        ProvincialBracketDictionary[Location.Nova_Scotia]?.insert(0.1667, forKey: 59180, atIndex: 2)
        ProvincialBracketDictionary[Location.Nova_Scotia]?.insert(0.1495, forKey: 29590, atIndex: 3)
        ProvincialBracketDictionary[Location.Nova_Scotia]?.insert(0.0879, forKey: 0, atIndex: 4)
        
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.15, forKey: 127430, atIndex: 0)
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.13, forKey: 44601, atIndex: 1)
        ProvincialBracketDictionary[Location.Saskatchewan]?.insert(0.11, forKey: 0, atIndex: 2)
        
        
    
       // InterestThreshold = [73145 : 0.2 , 86176: 0.36]
        InterestThreshold.insert(0.2, forKey: 73145, atIndex: 0)
        InterestThreshold.insert(0.36, forKey: 86176, atIndex: 1)
        //===========================================================================
        
        //init HealthPremium
        HealthPremium = [Location.Ontario : OrderedDictionary()]
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 200600, atIndex: 0)
        HealthPremium[Location.Ontario]?.insert(0.25, forKey: 200000, atIndex: 1)
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 72600, atIndex: 2)
        HealthPremium[Location.Ontario]?.insert(0.25, forKey: 72000, atIndex: 3)
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 48600, atIndex: 4)
        HealthPremium[Location.Ontario]?.insert(0.25, forKey: 48000, atIndex: 5)
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 38500, atIndex: 6)
        HealthPremium[Location.Ontario]?.insert(0.06, forKey: 36000, atIndex: 7)
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 25000, atIndex: 8)
        HealthPremium[Location.Ontario]?.insert(0.06, forKey: 20000, atIndex: 9)
        HealthPremium[Location.Ontario]?.insert(0.0, forKey: 0, atIndex: 10)
        
    }
    func initBasicPersonalAmount(){
        BasicPersonalAmount = [Location.Federal: 11474, Location.Ontario:10011, Location.Alberta :18451, Location.British_Columbia : 10027, Location.Manitoba: 9134, Location.Saskatchewan: 15843, Location.Yukon: 11474, Location.New_Brunswick : 9758, Location.Nova_Scotia: 8481, Location.Saskatchewan: 15843]
    }
    func initBasicReduction(){
        // This is Basix Reduction Threshold
        BasicReduction = [Location.Ontario: 456, Location.British_Columbia : 432, Location.New_Brunswick: 624, Location.Nova_Scotia: 300]
    }
   

    func getProvinces() -> [String]{
        return self.province_list
    }
     func getMaritalList() -> [String]{
        return self.marital_status
    }
    //=======================helper =======================================
    
    func flag_a_group(amount : Double , _ collection : OrderedDictionary<Int, Double>) -> Int {
        var counter: Int = collection.count
        for var i = 0 ; i < counter; ++i {
            var byIndex: (Int, Double) = collection[i]
            if Int(amount) > byIndex.0 {
                return counter - i
            }
        }
        return 1
        
    }
  
     //income : lower
    // total : higher
    func calculateTheDifference(lower: Double, _ higher : Double, _ group : OrderedDictionary<Int , Double>) -> Double{
        
        if higher < lower || lower < 0 {
            return 0
        }
        
        var top = flag_a_group(higher, group)
       // print("Top is \(top)")
        var bottom = flag_a_group(lower , group)
        //print("bottom is \(bottom)")
        var result = Double()
        var total_container : Double = higher
        for var i = top ; i > bottom - 1; --i {
            var byIndex: (Int, Double) = group[group.count - i]
            var level : Double = Double(byIndex.0)
           // level is the money
            var byKey: Double = group[Int(level)]!
           // bykey is the percentage
            if i == bottom {
                //level = income
                
                result = result + (total_container - lower) * byKey
                //print("where am i? \(result)")
                return Double(result)
            }
            result = result + (total_container - level) * byKey
            total_container =  Double(level)
        }
        return Double(result)
        
    }
    func foundation(lower:Double, _ higher: Double, _ province: String) ->(result: Double, process: String){
        var result = Double(0)
        var process =  String()
        
        //step one
        let StepOne = calculateTheDifference(lower, higher, FederalBracketDictionary)
        result = result + StepOne
        process =  "Federal:  \(StepOne)  \n"
        
        //step Two
        let StepTwo = calculateTheDifference(lower, higher , ProvincialBracketDictionary[Location(rawValue: province)!]!)
        result = result + StepTwo
        process = process + "Provincial: \(StepTwo)  \n"
        
        
        process = process + "Surtax %  Threshold \n"
        
        
        //StepThree & StepFour
        if province == Location.Ontario.rawValue { // Adding surtax seems only works for Ontario
        var counter:Int = InterestThreshold.count
        for var i = 0; i < counter; ++i {
            var byIndex: (Int, Double) = InterestThreshold[i]
            var keyCode = byIndex.0
            var finalStep = Double()
            if lower < Double(keyCode){
                finalStep = calculateTheDifference(Double(keyCode), higher,ProvincialBracketDictionary[Location(rawValue: province)!]! )  * byIndex.1

                result = result + finalStep
            } else {
                finalStep = calculateTheDifference(lower, higher,ProvincialBracketDictionary[Location(rawValue: province)!]! )  * byIndex.1
                result = result + finalStep
            }
           
                process = process + "\(byIndex.1*100)%       \(byIndex.0)      \(finalStep)\n"
            
          }
        }
        return (result, process)
    }
    func getSurtax(lower: Double, _ higher: Double, _ province: String) -> [Double]{
        var result = [Double]()
        var counter:Int = InterestThreshold.count
        for var i = 0; i < counter; ++i {
            var byIndex: (Int, Double) = InterestThreshold[i]
            var keyCode = byIndex.0
            var finalStep = Double()
            if lower < Double(keyCode){
                finalStep = calculateTheDifference(Double(keyCode), higher,ProvincialBracketDictionary[Location(rawValue: province)!]! )  * byIndex.1
                result.append(finalStep)
            } else {
                finalStep = calculateTheDifference(lower, higher,ProvincialBracketDictionary[Location(rawValue: province)!]! )  * byIndex.1
                result.append(finalStep)
            }
        }
        return result
        
    }
    
    
    //helper functions
    //rrsp: income, contribution, vary = income-contribution
    //interest:
    //mode: Federal/Other province
    //selection: pos/true: interest income,  neg/false: rrsp
    func BasicPersonalAmount(profileIncome: Double, _ other: Double, _ mode: Location, _ selection: Bool) -> Double{
        
        if selection == false {
            var income = profileIncome
            var contribution = other
            var vary = income - contribution
            var percentage : Double = self.TaxCredit[mode]!
            var basicPersonalAmount : Double = self.BasicPersonalAmount[mode]!
            
            //percentage should be 15% always
            if income > basicPersonalAmount {
                if vary >= basicPersonalAmount {
                    return 0.0
                } else {
                    return (basicPersonalAmount - vary ) * percentage * -1
                }
            } else {
                return contribution  * percentage * -1
            }
        } else { // It is for interest income
            // for oas, let other equals oaspension - oasclawback
            // for foreignincome, other should exquals foreignIncome
            var income = profileIncome
            var interest = other
            var total = income + interest
            
            var percentage: Double = self.TaxCredit[mode]!
            var basicPersonalAmount :  Double = self.BasicPersonalAmount[mode]!
            
            
            if income >= basicPersonalAmount {
                return 0
            } else {
                if total > basicPersonalAmount {
                    return (basicPersonalAmount-income) * percentage * -1
                } else {
                    return interest * percentage * -1
                }
            }
            
            
        }
    }

    
    //=====================helper end=======================================
    func get2Digits(input : Double) ->String {
        //return String(format:"%.0f",input) //due to odd/even digit issues, this one cannot be used
        return String(format:"%.0f",input.roundTo(0))
        
    }
    //=====================Testing code======================================
    
    func RRSP_calculation(income: Double, _ contribution : Double) -> Double{
        var vary = income - contribution
        var result  =  Double(0)
        
        //Step 1
        print(Float(calculateTheDifference(vary, income, FederalBracketDictionary)))
        result = result + calculateTheDifference(vary, income, FederalBracketDictionary)
        //Step 2
        print(Float(calculateTheDifference(vary, income, ProvincialBracketDictionary[Location.Ontario]!)))
        result = result + calculateTheDifference(vary,income , ProvincialBracketDictionary[Location.Ontario]!)
        var counter: Int = InterestThreshold.count
         for var i = 0 ; i < counter; ++i {
            var byIndex: (Int, Double) = InterestThreshold[i]
            var keyCode = byIndex.0
        //for keyCode in InterestThreshold.keys {
            if vary < Double(keyCode) {
                print(calculateTheDifference(Double(keyCode), income,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!)
                result = result + calculateTheDifference(Double(keyCode), income,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!
            } else {
                print(calculateTheDifference(vary, income,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!)
                result = result + calculateTheDifference(vary, income,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!
            }
        }
        
        print("the result is \(result)")
        return result
        
    
    }
    
    
    
    
    func Interest_Calculation(income : Double, _ interest : Double) -> Double {
        var total_1: Double =  income + interest
        
        var result = Double(0)
       
        //Step 1
        print(Float(calculateTheDifference(income, total_1, FederalBracketDictionary)))
        result = result + calculateTheDifference(income, total_1, FederalBracketDictionary)
        //Step 2
        print(Float(calculateTheDifference(income, total_1, ProvincialBracketDictionary[Location.Ontario]!)))
        result = result + calculateTheDifference(income, total_1, ProvincialBracketDictionary[Location.Ontario]!)
        
        //Step 3
       /*
        if income < 73145 {
            print(Float(calculateTheDifference(73145, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[73145]!)
            result = result + Float(calculateTheDifference(73145, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[73145]!
        } else {
            print(Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[73145]!)
        }
        //Step 4
        if income < 86176 {
            print(Float(calculateTheDifference(86176, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[86176]!)
        } else
            print(Float(calculateTheDifference(income, total_1,ProvincialBracketDictionary["Ontario"]! ) ) * InterestThreshold[86176]!)
        }*/
        
        
        
        
        //Step 3 & 4
       // for keyCode in InterestThreshold.keys {
        var counter: Int = InterestThreshold.count
        for var i = 0 ; i < counter; ++i {
            var byIndex: (Int, Double) = InterestThreshold[i]
            var keyCode = byIndex.0
            if income < Double(keyCode) {
                print(calculateTheDifference(Double(keyCode), total_1,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!)
                result = result + calculateTheDifference(Double(keyCode), total_1,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!
            } else {
                print(calculateTheDifference(income, total_1,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!)
                result = result + calculateTheDifference(income, total_1,ProvincialBracketDictionary[Location.Ontario]! )  * InterestThreshold[keyCode]!
            }
        }
        
        
        print("the result is \(result)")
        return result
        
    }
    
    
}

