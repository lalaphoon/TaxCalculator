//
//  OptionsViewController.swift
//
//
//  Created by Mengyi LUO on 2016-08-30.
//
//

import Foundation
import UIKit

class OptionViewController: UIViewController, UIScrollViewDelegate{
    var scrollView: UIScrollView!
    var containerView:UIView!
   
  
    let s = NSSelectorFromString("moveIntoNext:")
    var category = Int()
    var topic = Int()
    var option = Int()
    
    func moveIntoNext(sender: AnyObject){
        option = sender.tag
        performSegueWithIdentifier("MoveIntoInputs", sender: self)
    }
    
    override func viewDidLoad() {
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width ,800)
        
        self.containerView =  UIView()
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        initContainerUi()
        containerView.userInteractionEnabled =  true
        scrollView.userInteractionEnabled = true
    }
    func initContainerUi(){
        var pos_y = 60
        let distance = 100
        let left = 30
        var r = [String:Int]()
        if category == INCOME{
            if topic == EMPLOYMENT{
               r = Employment
            }else if topic == DIVIDENDINCOME{
               r = Dividend_Income
            }else if topic == INTERESTINCOME{
            r = Interest_Income
            }else if topic == CAPITALGAIN{
            r = Capital_Gain
            }else if topic == RENTALINCOME{
            r = Rental_Income
            }else if topic == BUSINESSANDPROFESSIONALINCOME{
            r = Business_and_Professional_Income
            }else if topic == INVESTMENTINCOME{
            r = Investment_Income
            }else if topic == PENSIONOTHERINCOME{
            r = Pension_Other_Income
            }
            
        } else if category == DEDUCTION{
            if topic == COMPUTINGINVESTMENTINCOME{
            r = Computing_Investment_Income
            }else if topic == CAPITALTRANSACTION{
            r = Capital_Transactions
            }else if topic == RENTALPROPERTY{
            r = Rental_Property
            }else if topic == BUSINESSINCOME{
            r = Business_Income
            }else if topic == OTHER{
            r = Deduction_Other
            }
            
        }else if category == TAXCREDIT{
        
        }
        for i in r.keys{
            containerView.addOrangeBorderButton(i, s, CGFloat(left), CGFloat(pos_y), self.view.bounds.width - (CGFloat(left)*2), 67, r[i]!,self)
            pos_y += distance
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : BasicInputsViewController = segue.destinationViewController as! BasicInputsViewController
        DestinyVC.category = category
        DestinyVC.topic = topic
        DestinyVC.option = option
    }
    

}