//
//  UserSettingsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-22.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import CoreData

//name
//email(why we need email?)
//password(Don't do it)
//net income
//Province Territory of resident

//var CDF = CoreDataFetcher()
class UserSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //var CDS = CoreDataSaver()
    var TP = TaxPro()
  //  @IBOutlet weak var menuButton: UIBarButtonItem!
    //var pickOption = [String]()
    var firstnameTextField = UITextField()
    var lastnameTextField = UITextField()
    var provinceTextField =  UITextField()
    var maritalTextField = UITextField()
    var incomeTextField = UITextField()
    var province_pickerView = UIPickerView()
    var marital_pickerView = UIPickerView()
    let province_tag: Int = 3
    let marital_tag: Int = 4
    let income_tag: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide submenu
        /*
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
        
        // Do any additional setup after loading the view.
        
        //put layout on the user view
        self.navigationItem.title = "Profile"
        self.addTextField("First Name", 1, 43)
       // self.addTextField("Last Name", 2, 43, 160)
        self.addTextField("Province", province_tag, 43, 220)
       // self.addTextField("Select your marital status", marital_tag, 43, 280)
        self.addTextField("Net Income", income_tag, 43, 340)
        
        self.addGreenButton("Save", "save", 20, 500, self.view.bounds.width - 50, 50)
        
        //set up picker for these two textfields
        firstnameTextField = self.view.viewWithTag(1) as! UITextField
       // lastnameTextField = self.view.viewWithTag(2) as! UITextField
        provinceTextField =  self.view.viewWithTag(province_tag) as! UITextField
       // maritalTextField = self.view.viewWithTag(marital_tag) as! UITextField
        incomeTextField = self.view.viewWithTag(income_tag) as! UITextField
        
        //setup picker view
        province_pickerView.delegate = self
        province_pickerView.tag = province_tag
        
        //marital_pickerView.delegate = self
        //marital_pickerView.tag = marital_tag
        
        //Set specia keyboard for income
        
        incomeTextField.keyboardType = .DecimalPad
        
        //select particular content for pickOption
        /*
        if provinceTextField.editing {
            pickOption =  TP.province
        } else if maritalTextField.editing {
            pickOption =  TP.marital_status
        }*/
        
        
        //make the inputview link to picker view
        provinceTextField.inputView = province_pickerView
        //maritalTextField.inputView = marital_pickerView
        
        initSettings()
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save(){
        var i: User = User(firstname: firstnameTextField.text! , lastname: lastnameTextField.text! , province: provinceTextField.text! , income: Double(incomeTextField.text!)!, marital: maritalTextField.text!)!
       // CoreDataSaver.save_a_user_withUser(i)
        i.save()
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
        print(" No User Stored in Core Data")
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
            return TP.province_list.count
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
