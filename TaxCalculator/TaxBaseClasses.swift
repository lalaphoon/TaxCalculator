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
    func retrieveData()
    
    func getResult() -> Double
    func getTip() -> String
    func getInstruction() -> String
    func displayProcess() -> String
    //factory
    //static func make(string: String) -> Formula
}

class Calculator{
    let strategy : Formula
    
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
    func displayProcess() -> String{
        return self.strategy.displayProcess()
    }
    func initUI(VC: UIViewController)->UIView{
        return self.strategy.initUI(VC)
    }
    func setProfile(income: Double, province: String){
        self.strategy.setProfile(income, province: province)
    }
    func retrieveData(){
        self.strategy.retrieveData()
    }
    

}

