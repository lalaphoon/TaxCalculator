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
        
    }
    
    func initUI(VC:UIViewController)-> UIView{
        var containerView = UIView()
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93)
        contribution = containerView.returnTextField("Contribution", 43, 274, VC.view.bounds.width - (43*2))
        contribution.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567, 87, 36, VC)
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
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
      
        return TP.foundation(vary, income!, profileProvince!).result
    }
    func getInstruction() -> String{
        return "Dividend income of $" + String(contribution.text!) + " result in additional taxed payable of"
    }
    
    func retrieveData(){
        
    }
    func getTip() -> String {
        return "If an individual is a first-time home buyer, consider withdrawing funds from RRSP under the Home Buyers' Plan (HBP) of up to $25,000 given the funds are tax-deferred. The funds shall remain in the RRSP for at least 90 days before withdrawing under the HBP to avoid adverse tax consequences."
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