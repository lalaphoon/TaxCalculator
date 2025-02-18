//
//  ForeignInvestmentIncome.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-12-21.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

class ForeignInvestmentIncome: Formula {
    static let sharedInstance = ForeignInvestmentIncome()
    var TP = TaxPro()
    
    var isUSStock = UISwitch()
    
    var ForeignIncome = UITextField()
    var ForeignTaxPaid = UITextField()
    
    
    var Deduction_2012 : Double = 0
    var Deduction_2011 : Double = 0
    var ProportionOfNetForeignBusinessIncome : Double = 0
    var FederalForeignTaxCredit : Double = 0
    var ProvincialForeignTaxCredit : Double = 0
    
    var profileIncome : Double!
    var profileProvince : String!
    
    private init(){
        ForeignIncome.text = String(0.00)
        ForeignTaxPaid.text = String(0.00)
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num : CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        ForeignIncome = containerView.returnTextField("Foreign Income", 43, 274 + num, VC.view.bounds.width - (43*2))
        ForeignIncome.keyboardType = .DecimalPad
        containerView.addText("Is in US Stock", 90, 340 + num, 200, 50)
        isUSStock = containerView.returnSwitch("isUSStock:", VC , VC.view.bounds.width-86, 340 + num)
        ForeignTaxPaid = containerView.returnTextField("Foreign Tax Paid",43,500 + num, VC.view.bounds.width - (43*2))
        ForeignTaxPaid.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", 43, VC.view.bounds.height - 100 + num, VC.view.bounds.width - (43*2), 36, VC)
        return containerView
    }
    func setInputs(input: Double){
        ForeignIncome.text = TP.get2Digits(input)
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var income = profileIncome
        var foreignIncome = Double(self.ForeignIncome.text!)
        var total = income! + foreignIncome!
        
        //Necessary step
        //operationBeforeGettingResult()
        
        
        var result : Double = 0.0
        result = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getForeignInvestmentIncome(income, foreignIncome: foreignIncome!, foreignTaxPaid: Double(self.ForeignTaxPaid.text!)!, isUSStock: isUSStock.on).result)!
        
      
        
        return result
    }
    //====================================Extra Calculation=============================================================
    //ON,AB,BC
    func BasicPersonalAmount(mode: Location) -> Double{
        var income = profileIncome
        var foreignIncome = Double(self.ForeignIncome.text!)
        var total = income! + foreignIncome!
        
        var percentage: Double = TP.TaxCredit[mode]!
        var basicPersonalAmount :  Double = TP.BasicPersonalAmount[mode]!
        var province = Location(rawValue: profileProvince)
        
        if income >= basicPersonalAmount {
            return 0
        } else {
            
            
            if total > basicPersonalAmount {
                return (basicPersonalAmount-income) * percentage * -1
            } else {
                return foreignIncome! * percentage * -1
            }
        }
    }
    //ON,BC
    func getBasicReduction(netincome: Double, _ foreignIncome: Double) -> Double{
        return getSingleReduction(netincome) - getSingleReduction(netincome + foreignIncome - Deduction_2012 - Deduction_2011)
    }
    //ON,BC
    func getSingleReduction(val: Double, _ special: Bool = false, _ di: Double = 0) -> Double{
        var result = 0.0
        if profileProvince == Location.Ontario.rawValue {
        var a = TP.calculateTheDifference(0, val, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince)!]!)
        
        var b = Double()
        if val < TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! {
            b = val * TP.TaxCredit[Location(rawValue: profileProvince)!]!
        } else {
            b = TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! * TP.TaxCredit[Location(rawValue: profileProvince)!]!
        }
        
        b = a - b
        
        if b <= 0 {
            b = 0
        }
        if (special == true){
            if (b - di) <= 0 {
                b = 0
            } else {
                b = b-di
            }
        }
        var c = TP.BasicReduction[Location(rawValue: profileProvince)!]! - b
        if (c < 0) {
            c = 0
        }
        
        
         result = min(c, b)
        }
        else if profileProvince == Location.British_Columbia.rawValue {
            var a = TP.calculateTheDifference(0, val, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince)!]!)
            var b = Double()
            if val < TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! {
                b = val * TP.TaxCredit[Location(rawValue: profileProvince)!]!
            } else {
                b = TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! * TP.TaxCredit[Location(rawValue: profileProvince)!]!
            }
            b = a - b
            var c : Double = val - 19000 // where is 19000 coming from? where is 3.5% coming from?
            if c <= 0 {
                c = 0
            }
            var d = c * 0.035
            var e = TP.BasicReduction[Location(rawValue: profileProvince)!]! - d
            if e <= 0 {
                e = 0
            }
            result = min(b, e)
          
               // var stepone = min (result , getDividendTaxCredit(Location(rawValue: profileProvince)!) )
               // result = result - stepone
                var steptwo = min (result , -1 * getForeignTaxCredit(Location(rawValue: profileProvince)!))
                result = result - steptwo
            
        }
        
        return result
        
    }
    //ON
    func getHealthPremium() -> Double{
        var income = profileIncome
        var foreignIncome = Double(self.ForeignIncome.text!)
        var total = income! + foreignIncome!
        var incomeHealthPremium = TP.calculateTheDifference(0, income, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        var totalPremium = TP.calculateTheDifference(0, total - Deduction_2011 - Deduction_2012, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        return totalPremium - incomeHealthPremium
    }
    //BC
    func getProvincialCredit(netincome: Double, _ interest: Double) -> Double {
        return getSingleProvincialCredit(netincome ) - getSingleProvincialCredit(netincome + interest - Deduction_2011 -  Deduction_2012)
    }
    //BC
    func getSingleProvincialCredit(val: Double) -> Double {
        var c : Double = val - 15000 // where is 19000 coming from? where is 3.5% coming from?
        if c <= 0 {
            c = 0
        }
        var d = c * 0.02
        var e : Double = 75 - d
        if e <= 0 {
            e = 0
        }
        
        return e
    }
//This doesn't have dividend credit
    //ALL
    func foreignTaxCreditHelper(value : Double, _ mode : Location) -> Double {
        var a  : Double = Double()
        if mode == Location.Federal{
            a = TP.calculateTheDifference(0, value, TP.FederalBracketDictionary)
        } else {
            a = TP.calculateTheDifference(0, value, TP.ProvincialBracketDictionary[mode]!)
        }
        var b = Double()
        if value < TP.BasicPersonalAmount[mode]! {
            b = value * TP.TaxCredit[mode]!
        } else {
            b = TP.BasicPersonalAmount[mode]! * TP.TaxCredit[mode]!
        }
        return a - b
        
    }
    //ALL
    func getForeignTaxCredit(mode : Location) -> Double{
        var result : Double = 0
        var income = profileIncome
        var foreignIncome = Double(self.ForeignIncome.text!)
        var total = income! + foreignIncome!
     
            if mode == Location.Federal {
                result = -1 * min( TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary) + TP.BasicPersonalAmount(income, foreignIncome!, Location.Federal, true) ,FederalForeignTaxCredit)
            } else {
                result = -1 * min(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!) + TP.BasicPersonalAmount(income, foreignIncome!, Location.Ontario, true)  ,ProvincialForeignTaxCredit)
            }
        
        return result
    }
    //only be called when canadian corporation is off
    //Set up a value for Not EligibleFor FTC when usstock is on
    //ON,BC
    func operationBeforeGettingResult(){
        if profileProvince == Location.Ontario.rawValue{
        var NotEligibleForFTC : Double = 0
        var NetIncome = profileIncome                      //9000
        var foreignIncome = Double(self.ForeignIncome.text!)     //Foreign Income 8000
        var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
        var total = NetIncome! + foreignIncome!
        //var Deduction_2011: Double = 0
        // var Deduction_2012: Double = 0
        var ForeignTaxPaid : Double = min(ForeignTax!, foreignIncome!*0.15) //1200
        
        if isUSStock.on == true {
            if ForeignTax!/foreignIncome! > 0.15 {
                NotEligibleForFTC = ForeignTax! - (foreignIncome!*0.15)
                NotEligibleForFTC = NotEligibleForFTC * -1
                
            }
            
        } else {
            if ForeignTax!/foreignIncome! > 0.15 {
                Deduction_2011 = ForeignTax! - (foreignIncome!*0.15)
                print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                //Deduction_2011 =  * -1
                
            }
        }
        for var i = 0; i < Int(foreignIncome!); i++ {
            //var i: Double = 861
            
            var BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
            
            
            var instanceBasicPersonalTax : Double = foreignTaxCreditHelper(total - Double(i)-Deduction_2011, Location(rawValue: profileProvince)!)
            var surtax1 : Double = 0
            var surtax2 : Double = 0
            if instanceBasicPersonalTax >  4484 {
                surtax1 = (instanceBasicPersonalTax - 4484) * 0.2
            }
            if instanceBasicPersonalTax > 5739 {
                surtax2 = (instanceBasicPersonalTax - 5739) * 0.36
            }
            var basicReduction : Double = 0
            if TP.BasicReduction[Location(rawValue: profileProvince)!] >= instanceBasicPersonalTax {
                basicReduction = min(TP.BasicReduction[Location(rawValue: profileProvince)!]!-instanceBasicPersonalTax, instanceBasicPersonalTax)
                
            }
            var BasicPersonalTax = instanceBasicPersonalTax + surtax2 + surtax1 - basicReduction
            
            var ratio : Double = (foreignIncome! + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)
            
            var FTCLimitation = BasicFederalTax * ratio
            
            var right : Double = ForeignTaxPaid - min(ForeignTaxPaid, FTCLimitation) - min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
            
            var balance : Double = abs(Double(i) - right)
            
            if (balance < 1){
                
                Deduction_2012 = Double(i)
                print("Deduction_2012 is \(Deduction_2012)")
                ProportionOfNetForeignBusinessIncome = ratio
                FederalForeignTaxCredit = min(ForeignTaxPaid,FTCLimitation)
                ProvincialForeignTaxCredit = min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
                break
            }
            
        }
    }//End of Ontario
        else if profileProvince == Location.British_Columbia.rawValue {
            var NotEligibleForFTC : Double = 0
            var NetIncome = profileIncome                      //9000
            var foreignIncome = Double(self.ForeignIncome.text!) //Foreign Income 8000
            var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
            var total = NetIncome! + foreignIncome!
            //var Deduction_2011: Double = 0
            // var Deduction_2012: Double = 0
            var ForeignTaxPaid : Double = min(ForeignTax!, foreignIncome!*0.15) //1200
            
            if isUSStock.on == true {
                if ForeignTax!/foreignIncome! > 0.15 {
                    NotEligibleForFTC = ForeignTax! - (foreignIncome!*0.15)
                    NotEligibleForFTC = NotEligibleForFTC * -1
                    
                }
                
            } else {
                if ForeignTax!/foreignIncome! > 0.15 {
                    Deduction_2011 = ForeignTax! - (foreignIncome!*0.15)
                    // print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                    //Deduction_2011 =  * -1
                    
                }
            }
            for var i = 0; i < Int(foreignIncome!); i++ {
                //var i: Double = 861
                
                var BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
                
                // print("Basic Fedral Tax is  \(BasicFederalTax)")
                var BasicPersonalTax : Double = foreignTaxCreditHelper(total - Double(i)-Deduction_2011, Location(rawValue: profileProvince)!)
                
                var ratio : Double = (foreignIncome! + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)
                
                var FTCLimitation = BasicFederalTax * ratio
                
                var right : Double = ForeignTaxPaid - min(ForeignTaxPaid, FTCLimitation) - min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
                
                var balance : Double = abs(Double(i) - right)
                //print("i is \(i) and balance is \(balance)")
                if (balance < 1){
                    
                    Deduction_2012 = Double(i)
                    ProportionOfNetForeignBusinessIncome = ratio
                    FederalForeignTaxCredit = min(ForeignTaxPaid,FTCLimitation)
                    ProvincialForeignTaxCredit = min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
                    break
                }
                
            }

        }
        
    }
    //==============================Extra Calculation ended===========================================================
    func getInstruction() -> String{
        return "Foreign Income of $" + String(ForeignIncome.text!) + " results in current year additional taxes payable of"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var income = profileIncome
        var foreignIncome = Double(self.ForeignIncome.text!)
        var total = income! + foreignIncome!
        var output2 = [Double]()
        var output1 = ["Net Income", "Interest income"]
        output2 = [Double(profileIncome), Double(self.ForeignIncome.text!)!]
        var surtax = TP.getSurtax(income, total, profileProvince)
        var output3 = [["","","",""]]
        
        output3 = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getForeignInvestmentIncome(income, foreignIncome: foreignIncome!, foreignTaxPaid: Double(self.ForeignTaxPaid.text!)!, isUSStock: isUSStock.on).process)!
                return (output1 , output2, output3)
        
        
    }
    func getTip() -> String {
        return "Foreign income is taxed at the full marginal rate. Investments taxed at a higher rate should be kept in a registered account such as a RRSP or a TFSA. If there are no contribution room left in your RRSP or TFSA, consider investing money where you will earn a dividend income which may attract a lower tax rate due to the dividend tax credit. Profits from sale of capital property (such as stock portfolio) is entitled to preferential tax treatment as well since only 50% of the gain will be taxed by the government. \n\nTalk to a Canada Revenue Agency (CRA) agent to find out how much contribution room you have for RRSP and TFSA. Set up a registered account with your financial advisor and ensure your investment does not exceed the cumulative contribution limit otherwise you may be subject to a penalty."
        
    }
    func getDefinition() -> String {
        return "Foreign income is the income earned for setting aside your money in vehicles such as bank deposits, loans, bonds, debentures, promissory notes, treasury bills (T-Bills), guaranteed investment certificate (GIC), and other similar instruments."
    }
    func checkBasicInput() -> Bool {
        //return true
        if ForeignIncome.text == "" {
            ForeignIncome.backgroundColor = UIColor.customWarningColor()
            ForeignIncome.placeholder="Missing an input for foreign investment income"
            return false
        } else {
            ForeignIncome.backgroundColor = .clearColor()
            ForeignIncome.placeholder=""
            return true
        }
        
    }


} /*
        if profileProvince == Location.Ontario.rawValue {
         output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
            ["Province/Territory","","",profileProvince],
            ["Foreign Income","","",self.ForeignIncome.text!],
            ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                        ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
           
            ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
            ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, foreignIncome!))],
            ["Health Premium", profileProvince,"",TP.get2Digits(getHealthPremium())],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.Alberta.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Foreign Income","","",self.ForeignIncome.text!],
                ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                
                ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
                ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.British_Columbia.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Foriegn Income","","",self.ForeignIncome.text!],
                ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],

                ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],

                ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
                ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, foreignIncome!))],
                ["Provincial Credit", profileProvince,"",TP.get2Digits(getProvincialCredit(income, foreignIncome!))],
                
                ["Tax Payable","","",TP.get2Digits(self.getResult())]]

        }*/
 /*
        if profileProvince == Location.Ontario.rawValue {
            result = TP.foundation(income!, total-Deduction_2012-Deduction_2011, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, foreignIncome!) + getHealthPremium()  + getForeignTaxCredit(Location.Federal) + getForeignTaxCredit(Location(rawValue: profileProvince)!)
        } else if profileProvince == Location.Alberta.rawValue {
            result = TP.foundation(income!, total-Deduction_2012-Deduction_2011, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!)  + getForeignTaxCredit(Location.Federal) + getForeignTaxCredit(Location(rawValue: profileProvince)!)
        }
        else if profileProvince == Location.British_Columbia.rawValue {
            result = TP.foundation(income!, total - Deduction_2011 - Deduction_2012, profileProvince!).result + 
                        BasicPersonalAmount(Location.Federal) +
                        BasicPersonalAmount(Location(rawValue: profileProvince)!) + 
                        getBasicReduction(income, foreignIncome!) + 
                        getForeignTaxCredit(Location.Federal) + 
                        getForeignTaxCredit(Location(rawValue: profileProvince)!) + 
                        getProvincialCredit(income, foreignIncome!)
    
        }*/