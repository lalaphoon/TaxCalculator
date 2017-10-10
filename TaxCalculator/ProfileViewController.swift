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
       
        self.scrollView =  UIScrollView(frame: UIScreen.main.bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width , height: self.view.bounds.height)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()
        provincePickerView.backgroundColor = .white
        provincePickerView.showsSelectionIndicator = true
        
        provincePickerView.delegate = self
        provincePickerView.dataSource = self
        retrieveContainer()
        incomeTextField.keyboardType = .decimalPad
        provinceTextField.inputView = provincePickerView
        provinceTextField.inputAccessoryView = toolBar
        
        initToolBar()
        
        self.hideKeyboardWhenTappedAround()
       
        // Do any additional setup after loading the view.
    }
    
    func initToolBar() {
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.customOrangeColor()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ProfileViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ProfileViewController.donePicker))
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
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
            performSegue(withIdentifier: "MoveIntoResult", sender: self)
        }
        
    }
    func checkProfileInfo() -> Bool{
        if (incomeTextField.text == ""){
            incomeTextField.backgroundColor = UIColor.customWarningColor()
            incomeTextField.placeholder = "Please enter total income"
        } else {
            incomeTextField.backgroundColor = .clear
        }
        if (provinceTextField.text == ""){
            provinceTextField.backgroundColor = UIColor.customWarningColor()
            provinceTextField.placeholder = "Please select province/territory"
        } else {
            provinceTextField.backgroundColor = .clear
        }
        if (incomeTextField.text == "" || provinceTextField.text == ""){
            return false
        }
        else {
            return true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinyVC : ResultViewController = segue.destination as! ResultViewController
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
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return  TP.province_list.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return TP.province_list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        provinceTextField.text = TP.province_list[row]
        
    }
  
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let myScreenRect : CGRect = UIScreen.main.bounds
        var keyboardHeight: CGFloat = 260
        if textField == provinceTextField {
        keyboardHeight += 45
        }
        UIView.beginAnimations("animateView", context: nil)
        var movementDuration: TimeInterval = 0.35
        var needToMove: CGFloat = 0
        
        var frame: CGRect = self.view.frame
        if (textField.frame.origin.y + textField.frame.size.height + UIApplication.shared.statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight) ) {
            needToMove = (textField.frame.origin.y + textField.frame.size.height + UIApplication.shared.statusBarFrame.size.height) - (myScreenRect.size.height - keyboardHeight)
            
        }
        frame.origin.y = -needToMove
        self.view.frame = frame
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.beginAnimations("animateView", context: nil)
        var movementDuration: TimeInterval = 0.35
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
