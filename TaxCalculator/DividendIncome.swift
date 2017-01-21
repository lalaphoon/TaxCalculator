//
//  DividendIncome.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-24.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

class DividendIncome : Formula {
    static let sharedInstance = DividendIncome()
    var TP = TaxPro()
    var isCanadianCorporation = Bool()
    var inStockMarket = Bool()
    
    var DivInc = UITextField()
    var ForeignTaxPaid = UITextField()
    var CanadianCorporation = UISwitch()
    var StockMarket = UISwitch()
    var USStock = UISwitch()
    
    var Deduction_2012 : Double = 0
    var Deduction_2011 : Double = 0
    var ProportionOfNetForeignBusinessIncome: Double = 0
    var FederalForeignTaxCredit : Double = 0
    var ProvincialForeignTaxCredit : Double = 0
    
    
    var profileIncome : Double!
    var profileProvince : String!
    
    private init(){
        DivInc.text = String(0.00)
    }
    
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        DivInc = containerView.returnTextField("Dividend Income", 43, 274 + num, VC.view.bounds.width - (43*2))
        DivInc.keyboardType = .DecimalPad
        containerView.addText("Canadian Corporation", 90, 340 + num, 200, 50)
        CanadianCorporation = containerView.returnSwitch("isCanadianCorporation:", VC , VC.view.bounds.width-86, 340 + num)
        containerView.addText("Company trade in stock market", 90, 390 + num, 200, 50)
        StockMarket = containerView.returnSwitch("isStockMarket:",VC, VC.view.bounds.width-86, 390 + num)
        containerView.addText("In US Stock", 90, 440, 200, 50)
        USStock = containerView.returnSwitch("isUSStock:",VC, VC.view.bounds.width-86, 440 + num)
        ForeignTaxPaid = containerView.returnTextField("Foreign Tax Paid",43,500 + num, VC.view.bounds.width - (43*2))
        ForeignTaxPaid.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", 43, VC.view.bounds.height - 100 + num, VC.view.bounds.width - (43*2), 36, VC)
        
        return containerView
    }
    //Not gonna use
    /*func isCanadianCorporation(sender: UISwitch){
        if (sender.on == true) {
            //println()
        } else {
            
        }
    }
    func isStockMarket(sender: UISwitch){
        if (sender.on == true){
        
        } else {
        
        }
    }
    func isUSStock(sender: UISwitch){
        if sender.on == true {
        
        } else {
        
        }
    }*/
    func setInputs(input: Double){
        DivInc.text = TP.get2Digits(input)
    }
    func setProfile(income: Double, province: String){
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
       /* if CanadianCorporation.on == true {
            if StockMarket.on == true { //Company trade in stock is "Yes"
                
            }
            else{//Company trade in stock is "No"
            
            }
        } else {
            
        }*/
        var income = profileIncome
        var dividendIncome = Double(self.DivInc.text!)
        var total = income! + dividendIncome!
        
        if (CanadianCorporation.on == false) {
           operationBeforGettingResult()
        }
        print("Deduction 2011 is ...\(Deduction_2011)")
        print("Deduction 2012 is ...\(Deduction_2012)")
        var result : Double = 0.0
        result = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getDividendIncome(income!, dividendIncome: dividendIncome!, ForeignTaxPaid: Double(self.ForeignTaxPaid.text!)!, CanadianCorporation: CanadianCorporation.on, StockMarket: StockMarket.on, isUSStock: USStock.on).result)!
        
        
        /*
        
        if profileProvince == Location.Ontario.rawValue {
            
            result = TP.foundation(income!, total-Deduction_2012-Deduction_2011, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, dividendIncome!) + getHealthPremium() + getDividendTaxCredit(Location.Federal) + getDividendTaxCredit(Location(rawValue: profileProvince!)!) + getForeignTaxCredit(Location.Federal) + getForeignTaxCredit(Location(rawValue: profileProvince)!)
            
        } else if profileProvince == Location.Alberta.rawValue {
            
            result = TP.foundation(income!, total-Deduction_2012-Deduction_2011, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getDividendTaxCredit(Location.Federal) + getDividendTaxCredit(Location(rawValue: profileProvince!)!) + getForeignTaxCredit(Location.Federal) + getForeignTaxCredit(Location(rawValue: profileProvince)!)
        }
        else if profileProvince == Location.British_Columbia.rawValue {
            result = TP.foundation(income!, total-Deduction_2012-Deduction_2011, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, dividendIncome!) + getProvincialCredit(income, dividendIncome!) + getDividendTaxCredit(Location.Federal) + getDividendTaxCredit(Location(rawValue: profileProvince!)!) + getForeignTaxCredit(Location.Federal) + getForeignTaxCredit(Location(rawValue: profileProvince)!)
        }
        */
        
        return result
        
        
    }
    //====================================Extra Calculation=============================================================
    //ON,AB,BC
    func BasicPersonalAmount(mode: Location, _ totalDeduction : Double = 0.0) -> Double{
        var income = profileIncome
        var dividendIncome = Double(self.DivInc.text!)
        var total = income! + dividendIncome!
        
        var percentage: Double = TP.TaxCredit[mode]!
        var basicPersonalAmount :  Double = TP.BasicPersonalAmount[mode]!
        var province = Location(rawValue: profileProvince)
        var totalDed : Double = 0.0
        if income >= basicPersonalAmount {
            return 0
        } else {
            if CanadianCorporation.on == false {
                totalDed = totalDeduction
            }
            if total + totalDed > basicPersonalAmount {
                return (basicPersonalAmount-income) * percentage * -1
            } else {
                return (dividendIncome! + totalDed) * percentage * -1
            }
        }
    }
    //ON,BC
    func getBasicReduction(netincome: Double, _ dividendIncome: Double) -> Double{
        var result : Double = 0.0
        if profileProvince == Location.Ontario.rawValue{
        result =  getSingleReduction(netincome) - getSingleReduction(netincome + dividendIncome - Deduction_2012 - Deduction_2011, true,-1 * getDividendTaxCredit(Location(rawValue: profileProvince!)!))
        } else if profileProvince == Location.British_Columbia.rawValue {
            result =  getSingleReduction(netincome) - getSingleReduction(netincome + dividendIncome - Deduction_2011 - Deduction_2012, true)
        }
        return result
    }
    //ON,BC
    func getSingleReduction(val: Double, _ special: Bool = false, _ di: Double = 0) -> Double{
        var result = 0.0
        if profileProvince == Location.Ontario.rawValue{
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
        } else if profileProvince == Location.British_Columbia.rawValue {
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
            if special == true {
                var stepone = min (result , getDividendTaxCredit(Location(rawValue: profileProvince)!) )
                result = result - stepone
                var steptwo = min (result , -1 * getForeignTaxCredit(Location(rawValue: profileProvince)!))
                result = result - steptwo
            }
            
        }
        return result
        
    }
    //ON
    func getHealthPremium() -> Double{
        var income = profileIncome
        var dividendIncome = Double(self.DivInc.text!)
        var total = income! + dividendIncome!
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
    
    
    //if CanadianCorporation is on, dividend tax credit will have a value
    //==> Stock market is on
    //==> stock market is off
    func getDividendTaxCredit(mode: Location) -> Double{
        var result : Double = 0.0
        var dividendIncome = Double(self.DivInc.text!)
        var income = profileIncome
        var total = income! + dividendIncome!
        var compare: Double = 0.0
        
        if mode == Location.Federal {
            compare = TP.calculateTheDifference(income, total, TP.FederalBracketDictionary) + BasicPersonalAmount(mode)
        } else {
            compare = TP.calculateTheDifference(income, total, TP.ProvincialBracketDictionary[mode]!) + BasicPersonalAmount(mode)
        }
        
        if CanadianCorporation.on == true {
            if StockMarket.on == true {
                result = dividendIncome! * TP.EligibleDividendTaxCredit[mode]!
            } else {
                result = dividendIncome! * TP.Non_EligibleDividendTaxCredit[mode]!
            }
        }
        
        result = min(result, compare)

        return result * -1
    }
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
        var dividendIncome = Double(self.DivInc.text!)
        var total = income! + dividendIncome!
        if CanadianCorporation.on == false {
            if mode == Location.Federal {
            result = -1 * min( TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary) + BasicPersonalAmount(Location.Federal) + getDividendTaxCredit(Location.Federal),FederalForeignTaxCredit)
            } else {
            result = -1 * min(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!) + BasicPersonalAmount(Location(rawValue: profileProvince!)!) + getDividendTaxCredit(Location(rawValue: profileProvince!)!) ,ProvincialForeignTaxCredit)
            }
        }
        return result
    }
    
    //only be called when canadian corporation is off
    //Set up a value for Not EligibleFor FTC when usstock is on
    //ON, BC
    func operationBeforGettingResult(){
        if profileProvince ==  Location.Ontario.rawValue{
            var NotEligibleForFTC : Double = 0
            var NetIncome = profileIncome                      //9000
            var dividendIncome = Double(self.DivInc.text!)     //Foreign Income 8000
            var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
            var total = NetIncome! + dividendIncome!
            //var Deduction_2011: Double = 0
            // var Deduction_2012: Double = 0
            var ForeignTaxPaid : Double = min(ForeignTax!, dividendIncome!*0.15) //1200
        
            if USStock.on == true {
                if ForeignTax!/dividendIncome! > 0.15 {
                    NotEligibleForFTC = ForeignTax! - (dividendIncome!*0.15)
                    NotEligibleForFTC = NotEligibleForFTC * -1
                
                }
        
            } else {
                if ForeignTax!/dividendIncome! > 0.15 {
                    Deduction_2011 = ForeignTax! - (dividendIncome!*0.15)
                    // print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                    //Deduction_2011 =  * -1
                
                }
            }
            for var i = 0; i < Int(dividendIncome!); i++ {
                //var i: Double = 861
          
                var BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
          
                // print("Basic Fedral Tax is  \(BasicFederalTax)")
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

                var ratio : Double = (dividendIncome! + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)

                var FTCLimitation = BasicFederalTax * ratio
          
                var right : Double = ForeignTaxPaid - min(ForeignTaxPaid, FTCLimitation) - min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
      
                var balance : Double = abs(Double(i) - right)
                //print("i is \(i) and balance is \(balance)")
                if (balance < 1){
                
                    Deduction_2012 = Double(i)
               
                    // print("Deduction_2012 is \(Deduction_2012)")
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
            var dividendIncome = Double(self.DivInc.text!)     //Foreign Income 8000
            var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
            var total = NetIncome! + dividendIncome!
            //var Deduction_2011: Double = 0
            // var Deduction_2012: Double = 0
            var ForeignTaxPaid : Double = min(ForeignTax!, dividendIncome!*0.15) //1200
            
            if USStock.on == true {
                if ForeignTax!/dividendIncome! > 0.15 {
                    NotEligibleForFTC = ForeignTax! - (dividendIncome!*0.15)
                    NotEligibleForFTC = NotEligibleForFTC * -1
                    
                }
                
            } else {
                if ForeignTax!/dividendIncome! > 0.15 {
                    Deduction_2011 = ForeignTax! - (dividendIncome!*0.15)
                    // print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                    //Deduction_2011 =  * -1
                    
                }
            }
            for var i = 0; i < Int(dividendIncome!); i++ {
                //var i: Double = 861
                
                var BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
                
                // print("Basic Fedral Tax is  \(BasicFederalTax)")
                var BasicPersonalTax : Double = foreignTaxCreditHelper(total - Double(i)-Deduction_2011, Location(rawValue: profileProvince)!)
                
                var ratio : Double = (dividendIncome! + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)
                
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
        }//End of British Columbia
    
    }
    //==============================Extra Calculation ended===========================================================

    func getInstruction() -> String{
       return "Dividend Income of $" + String(DivInc.text!) + " results in current year additional taxes payable of"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var income = profileIncome
        var dividendIncome = Double(self.DivInc.text!)
        var total = income! + dividendIncome!
        var output2 = [Double]()
        var output1 = ["Net Income", "Interest income"]
        output2 = [Double(profileIncome), Double(self.DivInc.text!)!]
        var surtax = TP.getSurtax(income, total, profileProvince)
        var output3 = [["","","",""]]
        output3 = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getDividendIncome(income!, dividendIncome: dividendIncome!, ForeignTaxPaid: Double(self.ForeignTaxPaid.text!)!, CanadianCorporation: CanadianCorporation.on, StockMarket: StockMarket.on, isUSStock: USStock.on).process)!
        /*
        if profileProvince == Location.Ontario.rawValue {
         output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
            ["Province/Territory","","",profileProvince],
            ["Dividend Income","","",self.DivInc.text!],
            ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
            ["Dividend Tax Credit","Federal","", TP.get2Digits(getDividendTaxCredit(Location.Federal))],
            ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
            ["Dividend Tax Credit",profileProvince,"",TP.get2Digits(getDividendTaxCredit(Location(rawValue: profileProvince)!))],
            ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
            ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, dividendIncome!))],
            ["Health Premium", profileProvince,"",TP.get2Digits(getHealthPremium())],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.Alberta.rawValue{
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Dividend Income","","",self.DivInc.text!],
                ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Dividend Tax Credit","Federal","", TP.get2Digits(getDividendTaxCredit(Location.Federal))],
                ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["Dividend Tax Credit",profileProvince,"",TP.get2Digits(getDividendTaxCredit(Location(rawValue: profileProvince)!))],
                ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
               ]
        } else if profileProvince == Location.British_Columbia.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Dividend Income","","",self.DivInc.text!],
                ["Foreign Tax Paid","","",self.ForeignTaxPaid.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Dividend Tax Credit","Federal","", TP.get2Digits(getDividendTaxCredit(Location.Federal))],
                ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["Dividend Tax Credit",profileProvince,"",TP.get2Digits(getDividendTaxCredit(Location(rawValue: profileProvince)!))],
                ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(Location(rawValue: profileProvince)!))],
                ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, dividendIncome!))],
                ["Provincial Credit", profileProvince,"",TP.get2Digits(getProvincialCredit(income, dividendIncome!))],
                
                ["Tax Payable","","",TP.get2Digits(self.getResult())]]

        }*/
        return (output1 , output2, output3)

    
    }
    func getTip() -> String {
        return "Dividend income is taxed at the full marginal rate. Investments taxed at a higher rate should be kept in a registered account such as a RRSP or a TFSA. If there are no contribution room left in your RRSP or TFSA, consider investing money where you will earn a dividend income which may attract a lower tax rate due to the dividend tax credit. Profits from sale of capital property (such as stock portfolio) is entitled to preferential tax treatment as well since only 50% of the gain will be taxed by the government. \n\nTalk to a Canada Revenue Agency (CRA) agent to find out how much contribution room you have for RRSP and TFSA. Set up a registered account with your financial advisor and ensure your investment does not exceed the cumulative contribution limit otherwise you may be subject to a penalty."

    }
    func getDefinition() -> String {
    return "Dividend income is the income earned for setting aside your money in vehicles such as bank deposits, loans, bonds, debentures, promissory notes, treasury bills (T-Bills), guaranteed investment certificate (GIC), and other similar instruments."
    }
    
    func checkBasicInput() -> Bool {
        //return true
        if DivInc.text == "" {
            DivInc.backgroundColor = UIColor.customWarningColor()
            DivInc.placeholder="Missing an input for dividend income"
            return false
        } else {
            DivInc.backgroundColor = .clearColor()
            DivInc.placeholder=""
            return true
        }

    }
}
