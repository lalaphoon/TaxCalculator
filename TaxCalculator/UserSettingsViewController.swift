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
    var pickOption = TP.province
    var provinceTextField =  UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
        self.addTextField("Type Your First Name", 1)
        self.addTextField("Type Your Last Name", 2, 20, 160)
        self.addTextField("Type your province", 3, 20, 220)
        
         provinceTextField =  self.view.viewWithTag(3) as! UITextField
        
        
        var pickerView = UIPickerView()
        pickerView.delegate = self
        provinceTextField.inputView = pickerView
        
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
        return pickOption.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        provinceTextField.text = pickOption[row]
    }

}
