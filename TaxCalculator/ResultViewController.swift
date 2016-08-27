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
    
    var scrollView : UIScrollView!
    var containerView: UIView!
    
    var c = Calculator(algorithm: RRSP.sharedInstance)

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

        // Do any additional setup after loading the view.
    }
    func initContainerUI(){
        //1.Setting up the title image
        containerView.addImage("Title_completed.png", self.view.bounds.width/2 - 65,93)
        
        //2.setting up the instruction
        var str = c.getInstruction()
        containerView.addText(str,self.view.bounds.width/2, 274, self.view.bounds.width-86, 100)
        
        //3.setting up the result for the green box
        var re = "$ " + String(c.getResult())
       // containerView.addGreenLabel(re, self.view.bounds.width/2, 345, self.view.bounds.width-86, 49)
        containerView.addLabelGreenButton(re, "viewProcess", 43, 325, self.view.bounds.width-86, 49, self)
        
        //4.setting up the tips
       // containerView.addText(c.getTip(), self.view.bounds.width/2, 440, self.view.bounds.width-86, 100)
        containerView.addYellowButton("Tax Tip", "viewTip", 43, 420, 100, 50, self)
        
        //5.Setting up the the start new calculat buttion
        containerView.addYellowButton("Start a new search", "StartNewCalculation", (self.view.bounds.width-169)/2, 565, 169, 50, self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewProcess(){
        performSegueWithIdentifier("MoveIntoProcess", sender: self)
    }
    func viewTip(){
         performSegueWithIdentifier("MoveIntoAfterResult", sender: self)
    }
    func StartNewCalculation() {
      print("cllicked!")
      //performSegueWithIdentifier("goBack", sender: self)
        navigationController?.popToRootViewControllerAnimated(true)
    //self.dismissViewControllerAnimated(false, completion: nil)
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
