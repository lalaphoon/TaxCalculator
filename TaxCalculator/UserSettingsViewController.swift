//
//  UserSettingsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-22.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
var TP = TaxPro()
class UserSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    //var pickOption = [String]()
    var provinceTextField =  UITextField()
    var maritalTextField = UITextField()
    var province_pickerView = UIPickerView()
    var marital_pickerView = UIPickerView()
    let province_tag: Int = 3
    let marital_tag: Int = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
        
        //put layout on the user view
        self.addTextField("Type Your First Name", 1)
        self.addTextField("Type Your Last Name", 2, 20, 160)
        self.addTextField("Type your province", 3, 20, 220)
        self.addTextField("Select your marital status", 4, 20, 280)
        
        //set up picker for these two textfields
        provinceTextField =  self.view.viewWithTag(province_tag) as! UITextField
        maritalTextField = self.view.viewWithTag(marital_tag) as! UITextField
        
        //setup picker view
        province_pickerView.delegate = self
        province_pickerView.tag = province_tag
        
        marital_pickerView.delegate = self
        marital_pickerView.tag = marital_tag
        
        
        //select particular content for pickOption
        /*
        if provinceTextField.editing {
            pickOption =  TP.province
        } else if maritalTextField.editing {
            pickOption =  TP.marital_status
        }*/
        
        
        //make the inputview link to picker view
        provinceTextField.inputView = province_pickerView
        maritalTextField.inputView = marital_pickerView
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return TP.province.count
        }
        if pickerView.tag == marital_tag
        {
            return TP.marital_status.count
        }
        
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == province_tag{
         return TP.province[row]
        }
        if pickerView.tag == marital_tag{
        return TP.marital_status[row]
        }
        
        return nil
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        if pickerView.tag == province_tag{
            provinceTextField.text = TP.province[row]
        }
        if pickerView.tag == marital_tag {
            maritalTextField.text = TP.marital_status[row]
        }
    }

}
