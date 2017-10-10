//
//  YukonTax.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2017-01-24.
//  Copyright © 2017 WTC Tax. All rights reserved.
//

import Foundation
class YukonTax : ProvincialTax {
    var TP = TaxPro()
    var location = Location.Yukon
    let profileProvince : String = Location.Yukon.rawValue
    func getRRSP(_ netIncome: Double, _ contribution: Double) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var vary = income - contribution
        var result : Double = 0.0
        result = TP.foundation(vary, income, location.rawValue).result + TP.BasicPersonalAmount(income, contribution,Location.Federal,false) + TP.BasicPersonalAmount(income,contribution,location,false)
        
        var process : [[String]] = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","", location.rawValue],
            ["RRSP Contribution","","", TP.get2Digits(contribution)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
            ["Basic personal amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, contribution,Location.Federal,false))],
            ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[location]!))],
            ["Basic personal amount", location.rawValue, "", TP.get2Digits(TP.BasicPersonalAmount(income,contribution,location,false))],
            ["Tax Payable", "","", TP.get2Digits(result)]]
        return (result, process)

    }
    func getInterestIncome(_ netIncome: Double, _ interestIncome: Double) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var interest = interestIncome
        var total = income + interest
        var result =  TP.foundation(income, total, location.rawValue).result + TP.BasicPersonalAmount(income, interest ,Location.Federal,true) + TP.BasicPersonalAmount(income, interest,location,true)
        var process : [[String]] = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",location.rawValue],
            ["Interest","","",TP.get2Digits(interest)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, interest ,Location.Federal,true))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total, TP.ProvincialBracketDictionary[location]!))],
            ["Basic Personal Amount",location.rawValue,"",TP.get2Digits(TP.BasicPersonalAmount(income, interest,location,true))],
            ["Tax Payable", "","", TP.get2Digits(result)]]
        return (result, process)
        
    }
    func getOldAgePension(_ netIncome: Double, _ OASPension: Double, _ OASClawback: Double) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var oaspension = OASPension
        var total = income + oaspension
        let profileProvince = location.rawValue
        //var OASClawback: Double = getOASClawback(income, OASPension: oaspension)
        var result = TP.foundation(income, total - OASClawback, location.rawValue).result + TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Federal, true) + TP.BasicPersonalAmount(income, oaspension - OASClawback, location, true)  + OASClawback
        var process :[[String]] = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",profileProvince],
            ["OAS Pension","","", TP.get2Digits(oaspension)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, oaspension - OASClawback, Location.Federal, true))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince)!]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(TP.BasicPersonalAmount(income, oaspension - OASClawback, location, true))],
            ["OAS Pension", "", "", TP.get2Digits(OASClawback)],
            ["Tax Payable","","",TP.get2Digits(result)]]
        
        return (result, process)
    }
    func getForeignInvestmentIncome(_ netIncome: Double, foreignIncome: Double, foreignTaxPaid: Double, isUSStock: Bool) -> (result: Double, process: [[String]]) {
        var income = netIncome
        var total = income + foreignIncome
        var Deduction_2012 : Double = 0
        var Deduction_2011 : Double = 0
        var ProportionOfNetForeignBusinessIncome : Double = 0
        var FederalForeignTaxCredit : Double = 0
        var ProvincialForeignTaxCredit : Double = 0
        var profileProvince =  location.rawValue
        (Deduction_2012,Deduction_2011,ProportionOfNetForeignBusinessIncome,FederalForeignTaxCredit, ProvincialForeignTaxCredit) = operationBeforeGettingResult(income, foreignIncome: foreignIncome, ForeignTax: foreignTaxPaid , isUSStock: isUSStock)
        
        var result = TP.foundation(income, total-Deduction_2012-Deduction_2011, profileProvince).result +
            TP.BasicPersonalAmount(income,foreignIncome,Location.Federal,true) +
            TP.BasicPersonalAmount(income, foreignIncome, location, true) +
            getForeignTaxCredit( income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Federal) +
            getForeignTaxCredit(income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, location)
        var process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",profileProvince],
            ["Foreign Income","","",TP.get2Digits(foreignIncome)],
            ["Foreign Tax Paid","","",TP.get2Digits(foreignTaxPaid)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits( TP.BasicPersonalAmount(income,foreignIncome,Location.Federal,true))],
            ["Foreign Tax Credit", "Federal", "",TP.get2Digits(getForeignTaxCredit( income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[location]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(TP.BasicPersonalAmount(income, foreignIncome, location, true))],
            
            ["Foreign Tax Credit", profileProvince,"",TP.get2Digits(getForeignTaxCredit(income,  foreignIncome , Deduction_2012,  Deduction_2011 , FederalForeignTaxCredit,  ProvincialForeignTaxCredit, location))],
            ["Tax Payable","","",TP.get2Digits(result)]]
        return (result, process)
        
    }
    func getDividendIncome(_ netIncome: Double, dividendIncome : Double, ForeignTaxPaid: Double, CanadianCorporation : Bool, StockMarket : Bool, isUSStock : Bool, dividF : Double, dividP : Double) -> (result:Double, process:[[String]]) {
        var income = netIncome
        var total = income + dividendIncome
        var Deduction_2012 : Double = 0
        var Deduction_2011 : Double = 0
        var ProportionOfNetForeignBusinessIncome : Double = 0
        var FederalForeignTaxCredit : Double = 0
        var ProvincialForeignTaxCredit : Double = 0
        
        var result : Double = 0.0
        var process = [["","","",""]]
        var federal_ForeignTaxCredit: Double = 0.0
        var provincial_ForeignTaxCredit : Double = 0.0
        var extraF : Double = 0.0
        var extraP : Double = 0.0
        //var dividF = f.getDividendTaxCredit(income, dividendIncome: dividendIncome, mode:Location.Federal,CanadianCorporation: CanadianCorporation, StockMarket:  StockMarket)
        //var dividP = f.getDividendTaxCredit(income, dividendIncome: dividendIncome, mode:Location.Ontario,CanadianCorporation: CanadianCorporation, StockMarket:  StockMarket)
        
        
        if CanadianCorporation == false {
            (Deduction_2012,Deduction_2011,ProportionOfNetForeignBusinessIncome,FederalForeignTaxCredit, ProvincialForeignTaxCredit) = operationBeforeGettingResult(income, foreignIncome: dividendIncome, ForeignTax: ForeignTaxPaid , isUSStock: isUSStock)
            
            extraF = dividF
            extraP = dividP
            //result = result +
            federal_ForeignTaxCredit =  getForeignTaxCredit(income, dividendIncome, Deduction_2012, Deduction_2011, FederalForeignTaxCredit, ProvincialForeignTaxCredit, Location.Federal, extraF)
            provincial_ForeignTaxCredit =  getForeignTaxCredit(income, dividendIncome, Deduction_2012, Deduction_2011, FederalForeignTaxCredit, ProvincialForeignTaxCredit, location, extraP)
            
        }
        result = TP.foundation(income, total-Deduction_2012-Deduction_2011, location.rawValue).result +
            TP.BasicPersonalAmount(income, dividendIncome, Location.Federal, true) +
            TP.BasicPersonalAmount(income, dividendIncome, location, true) +
            
            dividF +
        dividP
        
        
        result = result + federal_ForeignTaxCredit + provincial_ForeignTaxCredit
        process = [["Net Income","","", TP.get2Digits(income)],
            ["Province/Territory","","",location.rawValue],
            ["Dividend Income","","", TP.get2Digits(dividendIncome)],
            ["Foreign Tax Paid","","",TP.get2Digits(ForeignTaxPaid)],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(TP.BasicPersonalAmount(income, dividendIncome, Location.Federal, true))],
            ["Dividend Tax Credit","Federal","", TP.get2Digits(dividF)],
            ["Foreign Tax Credit", "Federal", "",TP.get2Digits(federal_ForeignTaxCredit)],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total-Deduction_2012-Deduction_2011, TP.ProvincialBracketDictionary[location]!))],
            ["Basic Personal Amount",location.rawValue,"",TP.get2Digits(TP.BasicPersonalAmount(income, dividendIncome, location, true))],
            ["Dividend Tax Credit",location.rawValue,"",TP.get2Digits(dividP)],
            ["Foreign Tax Credit", location.rawValue,"",TP.get2Digits(provincial_ForeignTaxCredit)],
            
            ["Tax Payable","","",TP.get2Digits(result)]]
        return (result,process)
    }
    func getForeignTaxCredit(_ income: Double, _ foreignIncome: Double, _ Deduction_2012 : Double, _ Deduction_2011 : Double, _ FederalForeignTaxCredit: Double, _ ProvincialForeignTaxCredit: Double, _ mode: Location, _ extraDividend : Double = 0.0) -> Double {
        var result : Double = 0
        
        var total = income + foreignIncome
        
        if mode == Location.Federal {
            result = -1 * min( TP.calculateTheDifference(income, total - Deduction_2012 - Deduction_2011, TP.FederalBracketDictionary) + TP.BasicPersonalAmount(income, foreignIncome, Location.Federal, true) + extraDividend ,FederalForeignTaxCredit)
        } else {
            result = -1 * min(TP.calculateTheDifference(income, total - Deduction_2012 - Deduction_2011, TP.ProvincialBracketDictionary[mode]!) + TP.BasicPersonalAmount(income, foreignIncome, mode, true) + extraDividend ,ProvincialForeignTaxCredit)
        }
        
        return result
    }
    func getBasicReduction(_ A: Double, _ B: Double, _ special: Bool, _ di: Double) -> Double {
        return 0
    }
    
    func getProvincialCredit(_ A : Double, _ B: Double) -> Double {
        return 0
    }
    //repeated now with ON
    func foreignTaxCreditHelper(_ value : Double, _ mode : Location) -> Double {
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
    func operationBeforeGettingResult(_ income: Double, foreignIncome: Double, ForeignTax: Double, isUSStock: Bool) -> (Deduction_2012: Double, Deduction_2011: Double, ProportionOfNetForeignBusinessIncome: Double, FederalForeignTaxCredit: Double, ProvincialForeignTaxCredit: Double) {
        var Deduction_2012 : Double = 0
        var Deduction_2011 : Double = 0
        var ProportionOfNetForeignBusinessIncome : Double = 0
        var FederalForeignTaxCredit : Double = 0
        var ProvincialForeignTaxCredit : Double = 0
        
        
        var NotEligibleForFTC : Double = 0
        let NetIncome = income                     //9000
        // var foreignIncome = Double(self.ForeignIncome.text!) //Foreign Income 8000
        // var ForeignTax = Double(self.ForeignTaxPaid.text!) //2000
        let total = NetIncome + foreignIncome
        //var Deduction_2011: Double = 0
        // var Deduction_2012: Double = 0
        let ForeignTaxPaid : Double = min(ForeignTax, foreignIncome*0.15) //1200
        
        if isUSStock == true {
            if ForeignTax/foreignIncome > 0.15 {
                NotEligibleForFTC = ForeignTax - (foreignIncome * 0.15)
                NotEligibleForFTC = NotEligibleForFTC * -1
                
            }
            
        } else {
            if ForeignTax/foreignIncome > 0.15 {
                Deduction_2011 = ForeignTax - (foreignIncome*0.15)
                // print("Deduction_2011 , the deduction 2011 is \(Deduction_2011)")
                //Deduction_2011 =  * -1
                
            }
        }
        for i in 0 ..< Int(foreignIncome) {
            //var i: Double = 861
            
            let BasicFederalTax : Double = foreignTaxCreditHelper(total - Double(i) - Deduction_2011, Location.Federal)
            
            // print("Basic Fedral Tax is  \(BasicFederalTax)")
            let BasicPersonalTax : Double = foreignTaxCreditHelper(total - Double(i)-Deduction_2011, location)
            
            let ratio : Double = (foreignIncome + NotEligibleForFTC - Double(i)-Deduction_2011)/(total - Double(i)-Deduction_2011)
            
            let FTCLimitation = BasicFederalTax * ratio
            
            let right : Double = ForeignTaxPaid - min(ForeignTaxPaid, FTCLimitation) - min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
            
            let balance : Double = abs(Double(i) - right)
            //print("i is \(i) and balance is \(balance)")
            if (balance < 1){
                
                Deduction_2012 = Double(i)
                ProportionOfNetForeignBusinessIncome = ratio
                FederalForeignTaxCredit = min(ForeignTaxPaid,FTCLimitation)
                ProvincialForeignTaxCredit = min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
                break
            }
            
        }
        return (Deduction_2012, Deduction_2011, ProportionOfNetForeignBusinessIncome, FederalForeignTaxCredit, ProvincialForeignTaxCredit)
    }
}
