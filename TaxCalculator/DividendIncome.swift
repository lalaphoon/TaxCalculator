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
    //var view =  UIView()
   // var VC = UIViewController()
    
    static let sharedInstance = RRSP()
    
    var TP = TaxPro()
    
    
   // var containerView = UIView()
    
    var contribution = UITextField()
    var provincePickerView =  UIPickerView()
    var provinceTextField = UITextField()
    var incomeTextField = UITextField()
    
    /*init(view: UIView){
        self.view = view
    }*/
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
    func initProfile(VC: UIViewController) -> UIView{
        var containerView = UIView()
        containerView.addImage("Title_profile.png", VC.view.bounds.width/2 - 65,93)
        incomeTextField=containerView.returnTextField("Your Income", 43,274, VC.view.bounds.width-86)
        provinceTextField=containerView.returnTextField("Your Province", 43, 334, VC.view.bounds.width-86)
        containerView.addYellowButton("Calculate", "moveToNext", VC.view.bounds.width-100, 567,87,36,VC)
        return containerView
    
    }
    func getResult() -> Double {
        var income = Double(incomeTextField.text!)
        var contribution = Double(self.contribution.text!)
        var vary = income! - contribution!
        //var result  =  Double(0)
        provinceTextField.text = "Ontario"
        return TP.foundation(vary, income!, provinceTextField.text!)
        
    }
    
    func retrieveData(){
        
    }
    func getTip() -> String {
        return "If an individual is a first-time home buyer, consider withdrawing funds from RRSP under the Home Buyers' Plan (HBP) of up to $25,000 given the funds are tax-deferred. The funds shall remain in the RRSP for at least 90 days before withdrawing under the HBP to avoid adverse tax consequences."
    }
    func displayProcess() {
    
    }
}