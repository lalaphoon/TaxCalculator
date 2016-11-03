//
//  DividendIncome.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-24.
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

    private init(){
        contribution.text = String(0.00)
    }
    
    func initUI(VC:UIViewController)-> UIView{
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        contribution = containerView.returnTextField("Contribution", 43, 274 + num, VC.view.bounds.width - (43*2))
        contribution.keyboardType = .DecimalPad
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
    func setInputs(input: Double){
        contribution.text = String(input)
    }
    func setProfile(income: Double, province: String){
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
      
        return TP.foundation(vary, income!, profileProvince!).result
    }
    func getInstruction() -> String{
        return "Dividend income of $" + String(contribution.text!) + " results in additional taxes payable for the current year of"
    }
    
    func retrieveData() -> ([String],[Double],[[String]]) {
        var output2 = [Double]() // We have to keep this for [Double?]/[Double!] -> [Double]
        var income = profileIncome
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        var output1 = ["Income", "Contribution"]
        output2 = [Double(profileIncome), Double(self.contribution.text!)!]
        var surtax = TP.getSurtax(vary,income, profileProvince)
        var interestthreshold = ["73145","86176"]
        var output3 = [["Income","","", "\(profileIncome)"],
                       ["Province","","",profileProvince],
                       ["Contribution","","",self.contribution.text!],
                       ["Federal","","","\(TP.calculateTheDifference(vary, income, TP.FederalBracketDictionary))"],
                       ["Province","","","\(TP.calculateTheDifference(vary, income, TP.ProvincialBracketDictionary[profileProvince!]!))"],
                       ["Surtax","%","Threshold",""],
                       ["","20%","\(interestthreshold[0])","\(surtax[0])"],
                       ["","36%","\(interestthreshold[1])", "\(surtax[1])"],
                       ["Result","","",String(self.getResult())]]
       // return(output1, another,[["Tested","","","\(12.3)"]])
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
}