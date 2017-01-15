//
//  ProvincialTaxPro.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2017-01-13.
//  Copyright © 2017 WTC Tax. All rights reserved.
//

import Foundation
protocol ProvincialTax {
    func getRRSP(netIncome: Double, _ contribution: Double ) -> (result:Double, process: [[String]])
    func getInterestIncome(netIncome: Double, _ interestIncome : Double) -> (result:Double , process: [[String]])
    func getOldAgePension(netIncome: Double, _ OASPension: Double) -> (result: Double, process: [[String]])
    func getForeignInvestmentIncome(netIncome: Double, foreignIncome: Double, foreignTaxPaid: Double, isUSStock: Bool) -> Double
    func getDividendIncome() -> Double
    
    func getBasicReduction(A: Double , _ B: Double ) -> Double
    func getHealthPremium(A: Double, _ B: Double) -> Double
    func getProvincialCredit() -> Double
    func getForeignTaxCredit(income: Double, _ foreignIncome: Double, _ Deduction_2012 : Double, _ Deduction_2011 : Double, _ FederalForeignTaxCredit: Double, _ ProvincialForeignTaxCredit: Double, _ mode: Location) -> Double
    
}

class OntarioTax : ProvincialTax {
    var TP = TaxPro()
    var interestthreshold = ["73145", "86176"]
    
    func getRRSP(netIncome: Double = 0, _ contribution: Double = 0) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var vary = income - contribution
        var result : Double = 0.0
        var surtax = TP.getSurtax(vary,income, Location.Ontario.rawValue)
        result = TP.foundation(vary, income, Location.Ontario.rawValue).result + TP.BasicPersonalAmount(income, contribution,Location.Federal,false) + TP.BasicPersonalAmount(income,contribution,Location.Ontario,false) + getBasicReduction(vary, income) + getHealthPremium(income, vary)
        //============================The rest process
        var process = [["","","",""]]
        process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",Location.Ontario.rawValue],
            ["RRSP Contribution","","",TP.get2Digits(contribution)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
            ["Basic personal amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, contribution,Location.Federal,false))],
            ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[Location.Ontario]!))],
            ["Basic personal amount", Location.Ontario.rawValue, "", TP.get2Digits(TP.BasicPersonalAmount(income,contribution,Location.Ontario,false))],
            ["Basic Reduction", Location.Ontario.rawValue , "" , TP.get2Digits(getBasicReduction(vary, income))],
            ["Health Premium", Location.Ontario.rawValue,"",TP.get2Digits(getHealthPremium(income, vary))],
            ["Surtax","%","Threshold",""],
            ["","20%","\(interestthreshold[0])",TP.get2Digits(surtax[0])],
            ["","36%","\(interestthreshold[1])", TP.get2Digits(surtax[1])],
            ["Taxes Payable","","", TP.get2Digits(result)]]
        
        
        return (result,process)
    }
    func getInterestIncome(netIncome: Double = 0, _ interestIncome: Double = 0) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var interest = interestIncome
        var total = income + interest
        var surtax = TP.getSurtax(income, total, Location.Ontario.rawValue)
        var result =  TP.foundation(income, total, Location.Ontario.rawValue).result + TP.BasicPersonalAmount(income, interest ,Location.Federal,true) + TP.BasicPersonalAmount(income, interest,Location.Ontario,true) + getBasicReduction(income, total) + getHealthPremium(total, income)
        var process = [["","","",""]]
        process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",Location.Ontario.rawValue],
            ["Interest","","", TP.get2Digits(interest)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, interest ,Location.Federal,true))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total, TP.ProvincialBracketDictionary[Location.Ontario]!))],
            ["Basic Personal Amount",Location.Ontario.rawValue,"",TP.get2Digits(TP.BasicPersonalAmount(income, interest,Location.Ontario,true))],
            ["Basic Reduction", Location.Ontario.rawValue, "" , TP.get2Digits(getBasicReduction(income, total))],
            ["Health Premium", Location.Ontario.rawValue,"",TP.get2Digits(getHealthPremium(total, income))],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["Tax Payable","","",TP.get2Digits(result)]]
        return (result, process)
    }
    func getOldAgePension(netIncome: Double, _ OASPension: Double) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var oaspension = OASPension
        var total = income + oaspension
        var OASClawback: Double = getOASClawback(income, OASPension: oaspension)
        var result = TP.foundation(income, total - OASClawback, Location.Ontario.rawValue).result + TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Federal, true) + TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Ontario, true) + getBasicReduction(income, total - OASClawback) + getHealthPremium(total - OASClawback, income) + OASClawback
        var surtax = TP.getSurtax(income, total - OASClawback, Location.Ontario.rawValue)
        var process = [["","","",""]]
        process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",Location.Ontario.rawValue],
            ["OASPension","","",TP.get2Digits(oaspension)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Federal, true))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.ProvincialBracketDictionary[Location.Ontario]!))],
            ["Basic Personal Amount",Location.Ontario.rawValue,"",TP.get2Digits(TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Ontario, true))],
            ["Basic Reduction", Location.Ontario.rawValue, "" , TP.get2Digits(getBasicReduction(income, oaspension))],
            ["Health Premium", Location.Ontario.rawValue,"",TP.get2Digits(getHealthPremium(total - OASClawback, income))],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["OAS Pension", "", "", TP.get2Digits(OASClawback)],
            ["Tax Payable","","",TP.get2Digits(result)]]
        return (result, process)
    }
    
    func getForeignInvestmentIncome(netIncome: Double, foreignIncome: Double, foreignTaxPaid : Double, isUSStock : Bool) -> Double {
        var income = netIncome
        var total = income + foreignIncome
        var Deduction_2012 : Double = 0
        var Deduction_2011 : Double = 0
        var ProportionOfNetForeignBusinessIncome : Double = 0
        var FederalForeignTaxCredit : Double = 0
        var ProvincialForeignTaxCredit : Double = 0
        var surtax = TP.getSurtax(income, total, Location.Ontario.rawValue)
        (Deduction_2012,Deduction_2011,ProportionOfNetForeignBusinessIncome,FederalForeignTaxCredit, ProvincialForeignTaxCredit) = operationBeforeGettingResult(income, foreignIncome: foreignIncome, ForeignTax: foreignTaxPaid , isUSStock: isUSStock)
        
        var result = TP.foundation(income, total - Deduction_2012 - Deduction_2011, Location.Ontario.rawValue).result +
            TP.BasicPersonalAmount(income,foreignIncome,Location.Federal,true) +
            TP.BasicPersonalAmount(income, foreignIncome, Location.Ontario, true) +
            getBasicReduction(income, foreignIncome) +
            getHealthPremium(total - Deduction_2012 - Deduction_2011, income)  +
            getForeignTaxCredit( income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Federal) +
            getForeignTaxCredit(income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Ontario)
        
        var process = [["","","",""]]
        process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","", Location.Ontario.rawValue],
            ["Foreign Income","","", TP.get2Digits(foreignIncome)],
            ["Foreign Tax Paid","","", TP.get2Digits(foreignTaxPaid)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income,foreignIncome,Location.Federal,true))],
            ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit( income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[Location.Ontario]!))],
            ["Basic Personal Amount",Location.Ontario.rawValue,"",TP.get2Digits(TP.BasicPersonalAmount(income, foreignIncome, Location.Ontario, true))],
            
            ["Foreign Tax Credit", Location.Ontario.rawValue,"",TP.get2Digits(getForeignTaxCredit(income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Ontario))],
            ["Basic Reduction", Location.Ontario.rawValue, "" , TP.get2Digits(getBasicReduction(income, foreignIncome))],
            ["Health Premium", Location.Ontario.rawValue,"",TP.get2Digits(getHealthPremium(total - Deduction_2012 - Deduction_2011, income))],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["Tax Payable","","",TP.get2Digits(result)]]
        
        return result
    }
    
    
    func getDividendIncome() -> Double {
        return 0
    }
    
    
    
    
    
    
    
    
    
    
    
    func getForeignTaxCredit(income: Double, _ foreignIncome: Double, _ Deduction_2012 : Double, _ Deduction_2011 : Double, _ FederalForeignTaxCredit: Double, _ ProvincialForeignTaxCredit: Double, _ mode: Location) -> Double {
        var result : Double = 0

        var total = income + foreignIncome
        
        if mode == Location.Federal {
            result = -1 * min( TP.calculateTheDifference(income, total - Deduction_2012 - Deduction_2011, TP.FederalBracketDictionary) + TP.BasicPersonalAmount(income, foreignIncome, Location.Federal, true) ,FederalForeignTaxCredit)
        } else {
            result = -1 * min(TP.calculateTheDifference(income, total - Deduction_2012 - Deduction_2011, TP.ProvincialBracketDictionary[mode]!) + TP.BasicPersonalAmount(income, foreignIncome, Location.Ontario, true)  ,ProvincialForeignTaxCredit)
        }
        
        return result
    }
  
 //helper functions
    func operationBeforeGettingResult(income: Double, foreignIncome: Double, ForeignTax: Double, isUSStock: Bool) -> (Deduction_2012: Double, Deduction_2011: Double, ProportionOfNetForeignBusinessIncome: Double, FederalForeignTaxCredit: Double, ProvincialForeignTaxCredit: Double){
        var Deduction_2012 : Double = 0
        var Deduction_2011 : Double = 0
        var ProportionOfNetForeignBusinessIncome : Double = 0
        var FederalForeignTaxCredit : Double = 0
        var ProvincialForeignTaxCredit : Double = 0
        
        var NotEligibleForFTC : Double = 0
        var NetIncome = income                     //9000
       // var foreignIncome = Double(self.ForeignIncome.text!)     //Foreign Income 8000
       // var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
        var total = NetIncome + foreignIncome
        //var Deduction_2011: Double = 0
        // var Deduction_2012: Double = 0
        var ForeignTaxPaid : Double = min(ForeignTax, foreignIncome * 0.15) //1200
        
        if isUSStock == true {
            if ForeignTax/foreignIncome  > 0.15 {
                NotEligibleForFTC = ForeignTax - (foreignIncome * 0.15)
                NotEligibleForFTC = NotEligibleForFTC * -1
                
            }
            
        } else {
            if ForeignTax / foreignIncome > 0.15 {
                Deduction_2011 = ForeignTax - (foreignIncome*0.15)
                print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                //Deduction_2011 =  * -1
                
            }
        }
        for var i = 0; i < Int(foreignIncome); i++ {
            //var i: Double = 861
            
            var BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
            
            
            var instanceBasicPersonalTax : Double = foreignTaxCreditHelper(total - Double(i)-Deduction_2011, Location.Ontario)
            var surtax1 : Double = 0
            var surtax2 : Double = 0
            if instanceBasicPersonalTax >  4484 {
                surtax1 = (instanceBasicPersonalTax - 4484) * 0.2
            }
            if instanceBasicPersonalTax > 5739 {
                surtax2 = (instanceBasicPersonalTax - 5739) * 0.36
            }
            var basicReduction : Double = 0
            if TP.BasicReduction[Location.Ontario] >= instanceBasicPersonalTax {
                basicReduction = min(TP.BasicReduction[Location.Ontario]!-instanceBasicPersonalTax, instanceBasicPersonalTax)
                
            }
            var BasicPersonalTax = instanceBasicPersonalTax + surtax2 + surtax1 - basicReduction
            
            var ratio : Double = (foreignIncome + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)
            
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
        return (Deduction_2012, Deduction_2011, ProportionOfNetForeignBusinessIncome, FederalForeignTaxCredit, ProvincialForeignTaxCredit)

    }
    
    
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
    
    func getOASClawback(netIncome: Double, OASPension: Double) -> Double {
        var income = netIncome
        var oaspension = OASPension
        var Threshold: Double = Double(72809)
        var clawbackPercentage: Double = 0.15
        var result1 : Double = 0.0
        var result2 : Double = 0.0
        
        if income >= Threshold {
            result1 = oaspension * clawbackPercentage
        }
        else if income + oaspension >= Threshold {
            result2 = ( income + oaspension - Threshold ) * clawbackPercentage
        }
        
        return result1 + result2
    }
    func getBasicReduction(A: Double, _ B: Double) -> Double{
        
        //rrsp: getSingleReduction(netincome - contribution) - getSingleReduction(netincome)
        //interst: getSingleReduction(netincome) - getSingleReduction(netincome + interest)
        return getSingleReduction(A) - getSingleReduction(B)
        
    }
    
    //Helper function for Basic Reduction
    func getSingleReduction(val: Double) -> Double {
        var result = 0.0
        var a = TP.calculateTheDifference(0, val, TP.ProvincialBracketDictionary[Location.Ontario]!)
        var b = Double()
        if val < TP.BasicPersonalAmount[Location.Ontario]! {
            b = val * TP.TaxCredit[Location.Ontario]!
        } else {
            b = TP.BasicPersonalAmount[Location.Ontario]! * TP.TaxCredit[Location.Ontario]!
        }
        b = a - b
        if b <= 0 {
            b = 0
        }
        var c = TP.BasicReduction[Location.Ontario]! - b
        if (c < 0) {
            c = 0
        }
        result = min(c, b)
        return result
    }
    
    func getHealthPremium(A: Double , _ B: Double ) -> Double {
        //rrsp: income - (income-contribution)
        //interest:
        var resultA = TP.calculateTheDifference(0, A, TP.HealthPremium[Location.Ontario]!)
        var resultB = TP.calculateTheDifference(0, B, TP.HealthPremium[Location.Ontario]!)
        return resultA - resultB
    }
    
    func getProvincialCredit() -> Double {
        return 0
    }
    
}