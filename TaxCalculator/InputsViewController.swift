//
//  InputsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class InputsViewController: UIViewController,UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var choice =  Int()
    
    var scrollView : UIScrollView!
    var containerView : UIView!
    var optionPickerView = UIPickerView()
    var optionTextField = UITextField()
    var dividendIncome = UITextField()
    var dividendIncomeList = ["Dividend income from securities", "Dividend income business", "Dividend income (non-eligible only)", "Dividend income from TFSA", "Dividend income from RRSP", "Other types of dividend income", "Capital Gains Dividends"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 667)
    
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()
        retrieveData()
        
        //containerView.
        
        dividendIncome.keyboardType = .DecimalPad
        
       // containerView.userInteractionEnabled = true
        //self.view = self.scrollView
      self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    func initContainerUI(){
        //if choice ==? {}
        containerView.addImage("Title_calculation.png", self.view.bounds.width/2 - 65, 93)
        containerView.addTextField("Dividend Income", 1, 43, 274, self.view.bounds.width - (43*2))
        containerView.addTextField("Choose an option", 2, 43, 334, self.view.bounds.width - (43*2))
       // containerView.userInteractionEnabled =  true
        containerView.addYellowButton("Next", "moveToNext", self.view.bounds.width - 100, 567, 87, 36, self)
        
    
    }
    func moveToNext(){
        performSegueWithIdentifier("MoveIntoProfile", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : ProfileViewController = segue.destinationViewController as! ProfileViewController
       // DestinyVC.choice = result
    }
    func retrieveData(){
        dividendIncome = self.view.viewWithTag(1) as! UITextField
        optionTextField = self.view.viewWithTag(2) as! UITextField
        optionPickerView.delegate = self
        optionPickerView.tag = 2
        optionTextField.inputView = optionPickerView
        
        
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
   /* override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //self.view.endEditing(true) /////<-------------?
        self.containerView.endEditing(true)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return dividendIncomeList.count
       
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return dividendIncomeList[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
           optionTextField.text = dividendIncomeList[row]
       
    }

}
