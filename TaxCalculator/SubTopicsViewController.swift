//
//  SubTopicsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class SubTopicsViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    let INCOME = 1
    let DEDUCTION = 2
    let TAXCREDIT = 3
    
    let employment =  4
    let dividend_income = 5
    let interest_income =  6
    let other_investment_income = 7
    let capital_gain = 8
    let rental_income = 9
    let business_and_professional_income = 10
    //let other_investment_income = 11
    let persion_and_other_income = 12
    
    let s = NSSelectorFromString("moveIntoNext:")
    
    func moveIntoNext(sender: UIButton){
        choice = sender.tag
        performSegueWithIdentifier("MoveIntoInputs", sender: self)
    }
    
    
    var choice = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width ,600)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        initContainerUi()

        // Do any additional setup after loading the view.
    }
    func initContainerUi(){
        if choice == INCOME {
         containerView.addOrangeBorderButton("Employment", s, 43, 60, self.view.bounds.width - 86, 53, employment)
            containerView.addOrangeBorderButton("Dividend Income", s, 43, 130, self.view.bounds.width - 86, 53, dividend_income)
            containerView.addOrangeBorderButton("Interest Income", s, 43, 200, self.view.bounds.width - 86, 53, interest_income)
            containerView.addOrangeBorderButton("Other Investment Income", s, 43, 270, self.view.bounds.width - 86, 53, other_investment_income)
            containerView.addOrangeBorderButton("Capital Gain", s, 43, 340, self.view.bounds.width - 86, 53, capital_gain)
            containerView.addOrangeBorderButton("Rental Income", s, 43, 410, self.view.bounds.width - 86, 53, rental_income)
            containerView.addOrangeBorderButton("Business and Professional Income", s, 43, 480, self.view.bounds.width - 86, 53, business_and_professional_income)
            
        }else if choice == DEDUCTION {
        
        }else if choice == TAXCREDIT {
        
        }
    
    }
    
    func initUI(){
        if choice == INCOME {
         self.addOrangeBorderButton("Employment1", s, 43, 138, self.view.bounds.width - (43*2) , 53, INCOME)
            
        }else if choice == DEDUCTION {
             self.addOrangeBorderButton("Employment1", "choiseEmployment", 43, 138, self.view.bounds.width - (43*2) , 53, DEDUCTION)
        
        }else if choice == TAXCREDIT {
         self.addOrangeBorderButton("Employment2", "choiseEmployment", 43, 138, self.view.bounds.width - (43*2) , 53 , TAXCREDIT)
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    //if we comment this out, we will not input anything...
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //self.view.endEditing(true) /////<-------------?
        self.containerView.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
