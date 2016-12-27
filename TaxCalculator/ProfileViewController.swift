//
//  ProfileViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-14.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var TP =  TaxPro()
    var choice = Int()
    var scrollView : UIScrollView!
    var containerView : UIView!
    
    var formula = Calculator(algorithm: RRSP.sharedInstance)

    
    var provincePickerView =  UIPickerView()
    var provinceTextField = UITextField()
    var incomeTextField = UITextField()
    
    let toolBar = UIToolbar()
    
   // var option = String() // given from inputviewController
   // var input = Double() // given from inputviewcontroller
    
    let province_tag: Int = 3
   // let marital_tag: Int = 4
    let income_tag : Int = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , self.view.bounds.height)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()
        provincePickerView.backgroundColor = .whiteColor()
        provincePickerView.showsSelectionIndicator = true
        
        provincePickerView.delegate = self
        provincePickerView.dataSource = self
        retrieveContainer()
        incomeTextField.keyboardType = .DecimalPad
        provinceTextField.inputView = provincePickerView
        provinceTextField.inputAccessoryView = toolBar
        
        initToolBar()
        
        self.hideKeyboardWhenTappedAround()
       
        // Do any additional setup after loading the view.
    }
    
    func initToolBar() {
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.customOrangeColor()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "donePicker")
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    }
    func donePicker(){
        view.endEditing(true)
    }
    func initContainerUI(){
        let num:CGFloat = -63
       containerView.addImage("Title_profile.png", self.view.bounds.width/2 - 65,93 + num)
       containerView.addTextField("Your Income", income_tag, 43,274 + num, self.view.bounds.width-86)
       containerView.addTextField("Province/Territory of Residence", province_tag, 43, 334 + num, self.view.bounds.width-86)
       containerView.addYellowButton("Calculate", "moveToNext", 43, self.view.bounds.height - 100 + num ,self.view.bounds.width-86,36,self)
    }
    func retrieveContainer(){
        incomeTextField = self.view.viewWithTag(income_tag) as! UITextField
        provinceTextField = self.view.viewWithTag(province_tag) as! UITextField
        provinceTextField.delegate = self
        incomeTextField.delegate = self
    }
    func moveToNext(){
        //translate choice to option
        //send option to next view
        
        if (checkProfileInfo()){
            //provinceTextField.text = "Ontario"
            formula.setProfile(Double(incomeTextField.text!)!, province: provinceTextField.text!)
            performSegueWithIdentifier("MoveIntoResult", sender: self)
        }
        
    }
    func checkProfileInfo() -> Bool{
        if (incomeTextField.text == ""){
            incomeTextField.backgroundColor = UIColor.customWarningColor()
            incomeTextField.placeholder = "Please enter total income"
        } else {
            incomeTextField.backgroundColor = .clearColor()
        }
        if (provinceTextField.text == ""){
            provinceTextField.backgroundColor = UIColor.customWarningColor()
            provinceTextField.placeholder = "Please select province/territory"
        } else {
            provinceTextField.backgroundColor = .clearColor()
        }
        if (incomeTextField.text == "" || provinceTextField.text == ""){
            return false
        }
        else {
            return true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : ResultViewController = segue.destinationViewController as! ResultViewController
        // DestinyVC.choice = choice
        DestinyVC.formula =  formula
       

        
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return  TP.province_list.count
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return TP.province_list[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        provinceTextField.text = TP.province_list[row]
        
    }
  
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == provinceTextField {
            if provinceTextField.text == ""{
                provinceTextField.text = TP.province_list[0]
            }
        }
        return true
    }
    
    /*
    func keyboardWillShow(notification: NSNotification){
        let myScreenRect : CGRect = UIScreen.mainScreen().bounds
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()

    }*/
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let myScreenRect : CGRect = UIScreen.mainScreen().bounds
        var keyboardHeight: CGFloat = 260
        if textField == provinceTextField {
        keyboardHeight += 45
        }
        UIView.beginAnimations("animateView", context: nil)
        var movementDuration: NSTimeInterval = 0.35
        var needToMove: CGFloat = 0
        
        var frame: CGRect = self.view.frame
        if (textField.frame.origin.y + textField.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight) ) {
            needToMove = (textField.frame.origin.y + textField.frame.size.height + UIApplication.sharedApplication().statusBarFrame.size.height) - (myScreenRect.size.height - keyboardHeight)
            
        }
        frame.origin.y = -needToMove
        self.view.frame = frame
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.beginAnimations("animateView", context: nil)
        var movementDuration: NSTimeInterval = 0.35
        var frame: CGRect = self.view.frame
        frame.origin.y = 0
        self.view.frame = frame
        UIView.commitAnimations()
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
