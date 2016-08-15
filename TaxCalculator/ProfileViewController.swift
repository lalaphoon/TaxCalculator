//
//  ProfileViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-14.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var TP =  TaxPro()
    var choice = Int()
    var scrollView : UIScrollView!
    var containerView : UIView!
    
    var provincePickerView =  UIPickerView()
    var provinceTextField = UITextField()
    var incomeTextField = UITextField()
    
    var option = String()
    var input = Double()
    
    let province_tag: Int = 3
   // let marital_tag: Int = 4
    let income_tag : Int = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 667)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()
        
        provincePickerView.delegate = self
        provinceTextField = self.view.viewWithTag(province_tag) as! UITextField
        incomeTextField = self.view.viewWithTag(income_tag) as! UITextField
        incomeTextField.keyboardType = .DecimalPad
        provinceTextField.inputView = provincePickerView
        
        
        
        self.hideKeyboardWhenTappedAround()
       
        // Do any additional setup after loading the view.
    }
    func initContainerUI(){
       containerView.addImage("Title_profile.png", self.view.bounds.width/2 - 65,93)
       containerView.addTextField("Your Income", income_tag, 43,274, self.view.bounds.width-86)
       containerView.addTextField("Your Province", province_tag, 43, 334, self.view.bounds.width-86)
       containerView.addYellowButton("Calculate", "moveToNext", self.view.bounds.width-100, 567,87,36,self)
    }
    func moveToNext(){
       // performSegueWithIdentifier("", sender: <#T##AnyObject?#>)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
