//
//  ResultViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UIScrollViewDelegate {
    
    var TP = TaxPro()
    
    var option = String()
    var province = String()
    var income = Double()
    var input = Double()
    
    var result =  Double()
    
    var scrollView : UIScrollView!
    var containerView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 667)
        
        self.containerView =  UIView()
        self.scrollView.userInteractionEnabled = true
        self.containerView.userInteractionEnabled = true
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()
        
      //  self.view.addText()

        // Do any additional setup after loading the view.
    }
    func initContainerUI(){
        containerView.addImage("Title_completed.png", self.view.bounds.width/2 - 65,93)
        
        var str = "Dividend income of $" + String(income) + " result in additional taxed payable of"
        containerView.addText(str,self.view.bounds.width/2, 274, self.view.bounds.width-86, 100)
        result =  TP.Interest_Calculation(income, input)
        var re = "$ " + String(result)
        //  containerView.addGreenLabel("This is a text", self.view.bounds.width/2, 200,self.view.bounds.width - 86, 49)

        containerView.addGreenLabel(re, self.view.bounds.width/2, 345, self.view.bounds.width-86, 49)
        containerView.addText("Tax Advice: \nContribution to RPP will reduce the conribution room available for RRSP an individual's T4 slip Box 20.", self.view.bounds.width/2, 440, self.view.bounds.width-86, 100)
        containerView.addYellowButton("Start a new search", "StartNewCalculation", (self.view.bounds.width-169)/2, 565, 169, 50, self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func StartNewCalculation() {
      print("cllicked!")
      performSegueWithIdentifier("goBack", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
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
