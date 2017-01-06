//
//  OldAgeSecurityPension.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-12-25.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
class Old_Age_Security_Pension : Formula{
    static let sharedInstance = Old_Age_Security_Pension()
    var TP = TaxPro()
    
    var OASPension = UITextField()
    var profileIncome : Double!
    var profileProvince : String!
    
    var OASClawback : Double = 0.0
    private init(){
    }
    
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num:CGFloat = -63
        containerView.addImage("Title_calculation.png",VC.view.bounds.width/2 - 65, 93 + num)
        OASPension = containerView.returnTextField("OAS Pension", 43, 274 + num, VC.view.bounds.width - (43*2))
        OASPension.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", 43, VC.view.bounds.height - 100 + num, VC.view.bounds.width - (43*2), 36, VC)
        return containerView
    }
    
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getOASClawback() -> Double {
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var Threshold: Double = Double(72809)
        var clawbackPercentage: Double = 0.15
        var result1 : Double = 0.0
        var result2 : Double = 0.0
        
        if income >= Threshold {
            result1 = oaspension! * clawbackPercentage
        }
        else if income + oaspension! >= Threshold {
            result2 = ( income + oaspension! - Threshold ) * clawbackPercentage
        }
        
        return result1 + result2
    }
    func getResult() -> Double {
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var total = income! + oaspension!
        
        OASClawback = getOASClawback()
        
        var result : Double = 0.0
        if profileProvince == Location.Ontario.rawValue {
            result = TP.foundation(income!, total - OASClawback, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, oaspension!) + getHealthPremium() + OASClawback
        } else if profileProvince == Location.Alberta.rawValue {
            result = TP.foundation(income!, total - OASClawback, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!)  + OASClawback
        } else if profileProvince == Location.British_Columbia.rawValue {
            result = TP.foundation(income!,total-OASClawback, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, oaspension!) + OASClawback + getProvincialCredit(income, oaspension!)
        }
        return result
    }
    func getInstruction() -> String {
        return " OAS Pension of $" + String(OASPension.text!) + " results in current year additional taxes payable of"
    }
    //==============================Extra Calculation===========================
    //ON,AB,BC
    func BasicPersonalAmount(mode : Location) -> Double{
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var total = income! + oaspension!
        
        var percentage : Double = TP.TaxCredit[mode]!
        var basicPersonalAmount : Double = TP.BasicPersonalAmount[mode]!
        var province = Location(rawValue: profileProvince)
        
        if income >= basicPersonalAmount {
            return 0
        } else {
            if total - OASClawback > basicPersonalAmount {
                return (basicPersonalAmount-income) * percentage * -1
            } else {
                return ( oaspension! - OASClawback ) * percentage * -1
            }
        }
    }
    //ON,BC
    func getBasicReduction(netincome: Double, _ oaspension: Double) -> Double{
        return getSingleReduction(netincome) - getSingleReduction(netincome + oaspension - OASClawback)
    }
    //ON,BC
    func getSingleReduction(val: Double) -> Double{
        var result = 0.0
        if profileProvince == Location.Ontario.rawValue {
        var a = TP.calculateTheDifference(0, val, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince)!]!)
        //print("a is \(a)")
        var b = Double()
        if val < TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! {
            b = val * TP.TaxCredit[Location(rawValue: profileProvince)!]!
        } else {
            b = TP.BasicPersonalAmount[Location(rawValue: profileProvince)!]! * TP.TaxCredit[Location(rawValue: profileProvince)!]!
        }
        // print("b1 is \(b)")
        b = a - b
        // print("b2 is \(b)")
        if b <= 0 {
            b = 0
        }
        var c = TP.BasicReduction[Location(rawValue: profileProvince)!]! - b
        if (c < 0) {
            c = 0
        }
        //print("c is \(c)")
         result = min(c, b)
        //print("result is \(result)")
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

        }
        return result
        
    }
    //ON
    func getHealthPremium() -> Double{
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var total = income! + oaspension! - OASClawback
        var incomeHealthPremium = TP.calculateTheDifference(0, income, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        var totalPremium = TP.calculateTheDifference(0, total, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        return totalPremium - incomeHealthPremium
    }
    //BC
    func getProvincialCredit(netincome: Double, _ oaspension: Double) -> Double {
        return getSingleProvincialCredit(netincome ) - getSingleProvincialCredit(netincome + oaspension - OASClawback)
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
 //================================End of Calculation========================================================
    func retrieveData() -> ([String],[Double],[[String]]){
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var total = income! + oaspension!
        var output2 = [Double]()
        var output1 = ["Net Income", "OAS Pension"]
        output2 = [Double(profileIncome), Double(self.OASPension.text!)!]
        var surtax = TP.getSurtax(income, total - OASClawback, profileProvince)
        var output3 = [["","","",""]]
        if profileProvince == Location.Ontario.rawValue{
          output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
            ["Province/Territory","","",profileProvince],
            ["Interest","","",self.OASPension.text!],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
            ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, oaspension!))],
            ["Health Premium", profileProvince,"",TP.get2Digits(getHealthPremium())],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["OAS Pension", "", "", TP.get2Digits(OASClawback)],
            ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.Alberta.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Interest","","",self.OASPension.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["OAS Pension", "", "", TP.get2Digits(OASClawback)],
                ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.British_Columbia.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["Interest","","",self.OASPension.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.FederalBracketDictionary))],
                ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total - OASClawback, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["Basic Reduction", profileProvince, "",TP.get2Digits(getBasicReduction(income, oaspension!))],
                ["Provincial Credit", profileProvince,"", TP.get2Digits(getProvincialCredit(income, oaspension!))],
                ["OAS Pension", "", "", TP.get2Digits(OASClawback)],
                ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        }
        return (output1 , output2, output3)
        
    }
    func getTip() -> String {
        return "If your net income exceeds $74,789, you will be required to pay back all or a portion of their OAS. This is known as the “OAS clawback”. The repayment is considered taxes payable which is 15% of the excess over $74,789, to a maximum of the total amount of OAS received.\n\n You should note that capital gain can increase the amount of OAS clawback, even if you have capital loss carried forward that will eliminate capital gain. This is because OAS clawback is calculated without factoring in capital loss carried forward from prior years. Therefore, if you have current year capital loss and also have unrealized gains, you should realize some of these capital gains to offset the losses in the same year.\n\n Government allows for the voluntary deferral of OAS pension for up to 5 years to receive a higher annual pension.  OAS pension will be increased by 0.6% for each month that it is deferred past the usual starting age of 65.  This is 7.2% for each full year that it is deferred.  If it is deferred for the maximum length of time, to age 70, it will be increased by 36%."
    }
    func getDefinition() -> String {
        return "Old Age Security (OAS) pension is a monthly social security payment available to most Canadians age 65 or older. \n\n You would generally qualify for OAS if you are a Canadian who have lived in Canada for at least 10 years after age 18. For Canadian living outside Canada, OAS is still available for those who were Canadian citizens or legal residents at the time they left the country, as long as they lived at least 20 years in Canada after age 18."
    }
    func checkBasicInput() -> Bool {
        //return true
        if OASPension.text == "" {
            OASPension.backgroundColor = UIColor.customWarningColor()
            OASPension.placeholder="Missing an input for OAS Pension"
            return false
        } else {
            OASPension.backgroundColor = .clearColor()
            OASPension.placeholder=""
            return true
        }
        
    }
    
    
    
}