//
//  InterestIncome.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-31.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

class InterestIncome: Formula{
    static let sharedInstance = InterestIncome()
    
    var TP = TaxPro()
    
    var interest = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    private init(){
        
    }
    
    func initUI(VC:UIViewController)-> UIView{
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        interest = containerView.returnTextField("Interest income", 43, 274 + num, VC.view.bounds.width - (43*2))
        interest.keyboardType = .DecimalPad
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
    func setProfile(income: Double, province: String){
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var income = profileIncome
        var interest = Double(self.interest.text!)
        var total = income! + interest!
        
        return TP.foundation(income!, total, profileProvince!).result + BasicPersonalAmount(Location.Federal) + BasicPersonalAmount(Location(rawValue: profileProvince)!) + getBasicReduction(income, interest!) + getHealthPremium()
    }
    func getInstruction() -> String{
        return "Dividend Income of $" + String(interest.text!) + " results in current year additional taxes payable of"
    }
    //====================================Extra Calculation=============================================================
    func BasicPersonalAmount(mode: Location) -> Double{
        var income = profileIncome
        var interest = Double(self.interest.text!)
        var total = income! + interest!
        
        var percentage: Double = TP.TaxCredit[mode]!
        var basicPersonalAmount :  Double = TP.BasicPersonalAmount[mode]!
        var province = Location(rawValue: profileProvince)
        
        if income >= basicPersonalAmount {
            return 0
        } else {
            if total > basicPersonalAmount {
                return (basicPersonalAmount-income) * percentage * -1
            } else {
                return interest! * percentage * -1
            }
        }
    }
    
    func getBasicReduction(netincome: Double, _ interest: Double) -> Double{
        return getSingleReduction(netincome) - getSingleReduction(netincome + interest)
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
        var interest = Double(self.interest.text!)
        var total = income! + interest!
        var incomeHealthPremium = TP.calculateTheDifference(0, income, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        var totalPremium = TP.calculateTheDifference(0, total, TP.HealthPremium[Location(rawValue: profileProvince)!]!)
        return totalPremium - incomeHealthPremium
    }
    
    
    
    //==================================Extra Calculation==============================================================
    func retrieveData() -> ([String],[Double],[[String]]){
        var income = profileIncome
        var interest = Double(self.interest.text!)
        var total = income! + interest!
        var output2 = [Double]()
        var output1 = ["Net Income", "Interest income"]
        output2 = [Double(profileIncome), Double(self.interest.text!)!]
        var surtax = TP.getSurtax(income, total, profileProvince)
        var output3 = [["Net Income","","", TP.get2Digits(profileIncome)],
            ["Province/Territory","","",profileProvince],
            ["Interest","","",self.interest.text!],
            ["Federal Tax","","",TP.get2Digits(TP.calculateTheDifference(income, total, TP.FederalBracketDictionary))],
            ["Basic Personal Amount","Federal","",TP.get2Digits(BasicPersonalAmount(Location.Federal))],
            ["Province/Territorial Tax","","", TP.get2Digits(TP.calculateTheDifference(income, total, TP.ProvincialBracketDictionary[Location(rawValue: profileProvince!)!]!))],
            ["Basic Personal Amount",profileProvince,"",TP.get2Digits(BasicPersonalAmount(Location(rawValue: profileProvince)!))],
            ["Basic Reduction", profileProvince, "" , TP.get2Digits(getBasicReduction(income, interest!))],
             ["Health Premium", profileProvince,"",TP.get2Digits(getHealthPremium())],
            ["Surtax","%","Threshold",""],
            ["","20%","73145",TP.get2Digits(surtax[0])],
            ["","36%","86176", TP.get2Digits(surtax[1])],
            ["Tax Payable","","",TP.get2Digits(self.getResult())]]
        return (output1 , output2, output3)

    }
    func getTip() -> String {
        return "Interest income is taxed at the full marginal rate. Investments taxed at a higher rate should be kept in a registered account such as a RRSP or a TFSA. If there are no contribution room left in your RRSP or TFSA, consider investing money where you will earn a dividend income which may attract a lower tax rate due to the dividend tax credit. Profits from sale of capital property (such as stock portfolio) is entitled to preferential tax treatment as well since only 50% of the gain will be taxed by the government. \n\nTalk to a Canada Revenue Agency (CRA) agent to find out how much contribution room you have for RRSP and TFSA. Set up a registered account with your financial advisor and ensure your investment does not exceed the cumulative contribution limit otherwise you may be subject to a penalty."
    }
    func getDefinition() -> String {
        return "Interest income is the income earned for setting aside your money in vehicles such as bank deposits, loans, bonds, debentures, promissory notes, treasury bills (T-Bills), guaranteed investment certificate (GIC), and other similar instruments."
    }
    func displayProcess() -> String {
        var process = String()
        process =           "-------------------------\n"
        process = process + "Income:       \(profileIncome)\n"
        process = process + "Province:     \(profileProvince)\n"
        process = process + "Interest: \(self.interest.text!)\n"
        process = process + "--------------------------\n"
        
        var income = profileIncome
        var contribution = Double(self.interest.text!)
        var vary = income! + contribution!
        process = process + "\(TP.foundation(income!, vary, profileProvince!).process)\n"
        process = process + "--------------------------\n"
        process = process + "result: \(self.getResult())\n"
        
        return process
        
        
    }
    func checkBasicInput() -> Bool {
        //return true
        if interest.text == "" {
            interest.backgroundColor = UIColor.customWarningColor()
            interest.placeholder="Missing an input for interest"
            return false
        } else {
            interest.backgroundColor = .clearColor()
            interest.placeholder=""
            return true
        }
    }
}