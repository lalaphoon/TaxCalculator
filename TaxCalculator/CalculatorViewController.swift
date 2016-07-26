//
//  CalculatorViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-14.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    var TP = TaxPro()
    var firstnameTextField = UITextField()
    var lastnameTextField = UITextField()
    var provinceTextField =  UITextField()
    var maritalTextField = UITextField()
    var incomeTextField = UITextField()
    var interestTextField = UITextField()
    var province_pickerView = UIPickerView()
    var marital_pickerView = UIPickerView()
    let province_tag: Int = 3
    let marital_tag: Int = 4
    let income_tag: Int = 5
    let interest_tag: Int = 6
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // initEverything()
       //self.addTextField( "Please input your name", 1)
        
        //put layout on the user view
        self.addTextField("Type Your First Name", 1)
        self.addTextField("Type Your Last Name", 2, 20, 160)
        self.addTextField("Type your province", province_tag, 20, 220)
        self.addTextField("Select your marital status", marital_tag, 20, 280)
        self.addTextField("Income", income_tag, 20, 340)
        self.addTextField("Interest", interest_tag, 20, 400)
        
        self.addOrangeButton("Next", "next", 20, 500, self.view.bounds.width - 50, 50)
        
        //set up picker for these two textfields
        firstnameTextField = self.view.viewWithTag(1) as! UITextField
        lastnameTextField = self.view.viewWithTag(2) as! UITextField
        provinceTextField =  self.view.viewWithTag(province_tag) as! UITextField
        maritalTextField = self.view.viewWithTag(marital_tag) as! UITextField
        incomeTextField = self.view.viewWithTag(income_tag) as! UITextField
        interestTextField = self.view.viewWithTag(interest_tag) as! UITextField
        
        //setup picker view
        province_pickerView.delegate = self
        province_pickerView.tag = province_tag
        
        marital_pickerView.delegate = self
        marital_pickerView.tag = marital_tag
        
        //Set specia keyboard for income
        
        incomeTextField.keyboardType = .DecimalPad
        interestTextField.keyboardType = .DecimalPad
        
        //make the inputview link to picker view
        provinceTextField.inputView = province_pickerView
        maritalTextField.inputView = marital_pickerView
        
        initSettings()

        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func next(){
    
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initEverything(){
        //self.addBackgroundImage("background.jpg", self)
        self.view.addBackground("background.jpg")
        self.view.darken(60)
        //self.addBlackLayer(self)
    }
    func initSettings(){
        let i: [User] = CoreDataFetcher.fetch_a_user()
        if i.count>0 {
            print("In user setting, there is at least one user, Reading....")
            self.firstnameTextField.text = i[i.count - 1].getFirstname()
            self.lastnameTextField.text = i[i.count - 1].getLastname()
            self.provinceTextField.text = i[i.count - 1].getProvince()
            self.incomeTextField.text = String(i[i.count - 1].getIncome())
            self.maritalTextField.text = i[i.count - 1].getMaritalStatus()
        } else {
            print("No user stored in Core Data")
        }
        
    }

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
        if pickerView.tag == province_tag
        {
            return TP.getProvinces().count
        }
        if pickerView.tag == marital_tag
        {
            return TP.marital_status.count
        }
        
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == province_tag{
            return TP.province_list[row]
        }
        if pickerView.tag == marital_tag{
            return TP.marital_status[row]
        }
        
        return nil
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == province_tag{
            provinceTextField.text = TP.province_list[row]
        }
        if pickerView.tag == marital_tag {
            maritalTextField.text = TP.marital_status[row]
        }
    }


}
