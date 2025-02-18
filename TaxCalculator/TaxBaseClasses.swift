//
//  TaxBaseClasses.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-22.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

enum Category {
case Income, Deduction, Credit
}
//All formulars will be writen in Strategy Design Pattern
//We probably should use Template Design Pattern

protocol Formula {
   // var containerView:UIView {set get}
    //init()
    func initUI(VC:UIViewController)->UIView
    func setProfile(income: Double, province: String)
    func retrieveData() -> ([String],[Double],[[String]])
    
    func getResult() -> Double
    func getTip() -> String
    func getDefinition() -> String
    func getInstruction() -> String
    //func displayProcess() -> String //  <----  Not gonna use this
    //factory
    //static func make(string: String) -> Formula
    func checkBasicInput() -> Bool
}

class Calculator{
    let strategy : Formula
    //let provincialTax : ProvincialTax
    
    init (algorithm:  Formula){
        self.strategy = algorithm
    }
    func getResult() -> Double{
        return self.strategy.getResult()
    }
    func getTip() -> String{
        return self.strategy.getTip()
    }
    func getInstruction() -> String{
        return self.strategy.getInstruction()
    }
   /* func displayProcess() -> String{
        return self.strategy.displayProcess()
    }*/
    func initUI(VC: UIViewController)->UIView{
        return self.strategy.initUI(VC)
    }
    func setProfile(income: Double, province: String){
        self.strategy.setProfile(income, province: province)
    }
    func retrieveData() -> ([String],[Double],[[String]]){
        return self.strategy.retrieveData()
    }
    func getDefinition() -> String {
        return self.strategy.getDefinition()
    }
    func checkBasicInput() -> Bool {
        return self.strategy.checkBasicInput()
    }
   
    //================================
    
}

