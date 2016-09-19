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
        containerView.addYellowButton("Next", "moveToNext", 43, 567 + num, VC.view.bounds.width - (43*2), 36, VC)
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
        
        return TP.foundation(income!, total, profileProvince!).result
    }
    func getInstruction() -> String{
        return "Dividend Income of $" + String(interest.text!) + " results in additional taxed payable for the current year of"
    }
    
    func retrieveData(){
        
    }
    func getTip() -> String {
        return "No tips."
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
}