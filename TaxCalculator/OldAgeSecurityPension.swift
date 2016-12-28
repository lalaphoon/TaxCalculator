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
        }
        return result
    }
    func getInstruction() -> String {
        return " OAS Pension of $" + String(OASPension.text!) + " results in current year additional taxes payable of"
    }
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
    func getBasicReduction(netincome: Double, _ oaspension: Double) -> Double{
        return getSingleReduction(netincome) - getSingleReduction(netincome + oaspension - OASClawback)
    }
    func getSingleReduction(val: Double) -> Double{
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
        var result = min(c, b)
        //print("result is \(result)")
        return result
        
    }
    func getHealthPremium() -> Double{
        var income = profileIncome
        var oaspension = Double(self.OASPension.text!)
        var total = income! + oaspension! - OASClawback
        var incomeHealthPremium = TP.calculateTheDifference(0, income, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        var totalPremium = TP.calculateTheDifference(0, total, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        return totalPremium - incomeHealthPremium
    }
    
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
        }
        return (output1 , output2, output3)
        
    }
    func getTip() -> String {
        return "Old Age Pension is taxed at the full marginal rate. Investments taxed at a higher rate should be kept in a registered account such as a RRSP or a TFSA. If there are no contribution room left in your RRSP or TFSA, consider investing money where you will earn a dividend income which may attract a lower tax rate due to the dividend tax credit. Profits from sale of capital property (such as stock portfolio) is entitled to preferential tax treatment as well since only 50% of the gain will be taxed by the government. \n\nTalk to a Canada Revenue Agency (CRA) agent to find out how much contribution room you have for RRSP and TFSA. Set up a registered account with your financial advisor and ensure your investment does not exceed the cumulative contribution limit otherwise you may be subject to a penalty."
    }
    func getDefinition() -> String {
        return "Old Age Pension is the income earned for setting aside your money in vehicles such as bank deposits, loans, bonds, debentures, promissory notes, treasury bills (T-Bills), guaranteed investment certificate (GIC), and other similar instruments."
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