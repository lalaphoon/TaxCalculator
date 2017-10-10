//
//  RRSP.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-12-01.
//  Copyright © 2016 WTC Tax. All rights reserved.
//



import Foundation
import UIKit
//Each algorithm is a singleton

class RRSP: Formula{
    static let sharedInstance = RRSP()
    
    var TP = TaxPro()
    
    
    var contribution = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    
    fileprivate init(){
        contribution.text = String(0.00)
    }
    
    func initUI(_ VC:UIViewController)-> UIView{
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        contribution = containerView.returnTextField("Contribution", 43, 274 + num, VC.view.bounds.width - (43*2))
        contribution.keyboardType = .decimalPad
        containerView.addYellowButton("Next", "moveToNext", 43, VC.view.bounds.height - 100 + num, VC.view.bounds.width - (43*2), 36, VC)
        return containerView
        
    }
    
    /*func initProfile(VC: UIViewController) -> UIView{
    var containerView = UIView()
    containerView.addImage("Title_profile.png", VC.view.bounds.width/2 - 65,93)
    incomeTextField=containerView.returnTextField("Your Income", 43,274, VC.view.bounds.width-86)
    provinceTextField=containerView.returnTextField("Your Province", 43, 334, VC.view.bounds.width-86)
    containerView.addYellowButton("Calculate", "moveToNext", VC.view.bounds.width-100, 567,87,36,VC)
    return containerView
    
    }*/
    func setInputs(_ input: Double){
        contribution.text = TP.get2Digits(input)
    }
    func setProfile(_ income: Double, province: String){
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        // if vary < 0 {
        //    vary = -vary }
        var result :Double = 0.0
     
        result = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getRRSP(income!, contribution!).result)!
        return result
        
        
    }
    func getInstruction() -> String{
        return "Dividend income of $" + String(contribution.text!) + " results in current year additional taxes payable of"
    }
    //====================================Extra Calculation==============================================
    //ON,AB,BC,MB
    func BasicPersonalAmount(_ mode: Location) -> Double{
        let income = profileIncome
        let contribution = Double(self.contribution.text!)
        let vary = income! - contribution!
        
        let percentage : Double = TP.TaxCredit[mode]!
        
        let basicPersonalAmount : Double = TP.BasicPersonalAmount[mode]!
        var province = Location(rawValue: profileProvince)
        
        //percentage should be 15% always
        if income! > basicPersonalAmount {
            if vary >= basicPersonalAmount {
                return 0.0
            } else {
                return (basicPersonalAmount - vary ) * percentage * -1
            }
        } else {
            return contribution!  * percentage * -1
        }
    }
    //ON,BC
    func getBasicReduction(_ netincome: Double, _ contribution: Double) -> Double{
        
        return getSingleReduction(netincome - contribution) - getSingleReduction(netincome)
        
    }
    //ON,BC
    func getSingleReduction(_ val: Double) -> Double{
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
        }
        
        
        return result
        
    }
    //ON
    func getHealthPremium() -> Double{
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        var incomeHealthPremium = TP.calculateTheDifference(0, income!, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        var contributionPremium = TP.calculateTheDifference(0, vary, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        return incomeHealthPremium - contributionPremium
    }
    
    //BC,MB
    func getProvincialCredit(_ netincome: Double, _ contribution: Double) -> Double {
        return  getSingleProvincialCredit(netincome) - getSingleProvincialCredit(netincome -  contribution)
    }
    //BC,MB
    func getSingleProvincialCredit(_ val: Double) -> Double {
        var result : Double = 0.0
        if profileProvince ==  Location.British_Columbia.rawValue {
            var c : Double = val - 15000 // where is 19000 coming from? where is 3.5% coming from?
            if c <= 0 {
                c = 0
            }
            let d = c * 0.02
            var e : Double = 75 - d
            if e <= 0 {
                e = 0
            }
            result = e
        } else if profileProvince == Location.Manitoba.rawValue {
            var c : Double = val
            if c <= 0 {
                c = 0
            }
            let d = c * 0.01
            var e : Double = 195 - d
            if e <= 0 {
                e = 0
            }
            result = e
        }
        return result
    }
    //==================================Extra Calculation=================================================
    func retrieveData() -> ([String],[Double],[[String]]) {
        var output2 = [Double]() // We have to keep this for [Double?]/[Double!] -> [Double]
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        var output1 = ["Net Income", "Contribution"]
        output2 = [Double(profileIncome), Double(self.contribution.text!)!]
       
        var output3 = [["","","",""]]

        output3 = (CurrentProvince.getData(Location(rawValue: profileProvince)!)?.getRRSP(income!, contribution!).process)!
       
        return (output1 , output2  , output3)
    }
    func getTip() -> String {
        return "If an individual is a first-time home buyer, consider withdrawing funds from RRSP under the Home Buyers' Plan (HBP) of up to $25,000 given the funds are tax-deferred. The funds shall remain in the RRSP for at least 90 days before withdrawing under the HBP to avoid adverse tax consequences."
    }
    func getDefinition() -> String {
        return "Registered Retirement Savings Plan (RRSP) is a plan designed to assist employed, self-employed and other individuals to defer tax on a limited part of their income for the purpose of retirement savings. Individuals may take a tax deduction in the current year for the RRSP contributions made if they have sufficient contribution room.\n\nYou can find your RRSP contribution room by checking your latest Notice of Assessment of by calling the CRA."
    }
    func displayProcess() -> String {
        var process = String()
        process =           "-------------------------\n"
        process = process + "Income:       \(profileIncome)\n"
        process = process + "Province:     \(profileProvince)\n"
        process = process + "Contribution: \(self.contribution.text!)\n"
        process = process + "--------------------------\n"
        
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        process = process + "\(TP.foundation(vary, income!, profileProvince!).process)\n"
        process = process + "--------------------------\n"
        process = process + "result: \(self.getResult())\n"
        
        return process
        
        
    }
    func checkBasicInput() -> Bool {
        //return true
        if contribution.text == "" {
            contribution.backgroundColor = UIColor.customWarningColor()
            contribution.placeholder = "Missing an input for contribution"
            return false
        } else {
            contribution.backgroundColor = .clear
            contribution.placeholder = ""
            return true
        }
    }
}



/*
        if profileProvince == Location.Ontario.rawValue {
         output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
            ["Province/Territory","","",profileProvince],
            ["RRSP Contribution","","",self.contribution.text!],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
            ["Basic personal amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
            ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
            ["Basic personal amount", profileProvince, "", TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
            ["Basic Reduction", profileProvince , "" , TP.get2Digits(getBasicReduction(income, contribution!))],
            ["Health Premium", profileProvince,"",TP.get2Digits(getHealthPremium())],
            ["Surtax","%","Threshold",""],
            ["","20%","\(interestthreshold[0])",TP.get2Digits(surtax[0])],
            ["","36%","\(interestthreshold[1])", TP.get2Digits(surtax[1])],
            ["Taxes Payable","","", TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.Alberta.rawValue {
            
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["RRSP Contribution","","",self.contribution.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
                ["Basic personal amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic personal amount", profileProvince, "", TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))]]
        } else if profileProvince == Location.British_Columbia.rawValue {
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["RRSP Contribution","","",self.contribution.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
                ["Basic personal amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic personal amount", profileProvince, "", TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["Basic Reduction", profileProvince , "" , TP.get2Digits(getBasicReduction(income, contribution!))],
                ["Provincial Credit", profileProvince,"", TP.get2Digits(getProvincialCredit(income, contribution!))],
                ["Taxes Payable","","", TP.get2Digits(self.getResult())]]
        } else if profileProvince == Location.Manitoba.rawValue{
            output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
                ["Province/Territory","","",profileProvince],
                ["RRSP Contribution","","",self.contribution.text!],
                ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))],
                ["Basic personal amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
                ["Province/Territorial Tax","","",TP.get2Digits(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
                ["Basic personal amount", profileProvince, "", TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
                ["Provincial Credit", profileProvince,"", TP.get2Digits(getProvincialCredit(income, contribution!))],
                ["Taxes Payable","","", TP.get2Digits(self.getResult())]]
        }
*/
/*
        if profileProvince == Location.Alberta.rawValue {
            result =  TP.foundation(vary, income!, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!)
        } else if profileProvince == Location.Ontario.rawValue {
            result = TP.foundation(vary, income!, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, contribution!) + getHealthPremium()
        } else if profileProvince == Location.British_Columbia.rawValue {
            result = TP.foundation(vary, income!, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, contribution!) + getProvincialCredit(income, contribution!)
        } else if profileProvince == Location.Manitoba.rawValue{
            result = TP.foundation(vary, income!, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getProvincialCredit(income, contribution!)
        }*/
