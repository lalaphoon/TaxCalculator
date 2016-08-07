//
//  ContactViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-24.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITextViewDelegate {
    
    
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var messageTextView =  UITextView()
    
    var placeholderLabel : UILabel!
    
    let name_tag : Int = 1
    let email_tag : Int = 2
    let message_tag : Int = 3
    

    func initUI(){
      self.addImage("Title_message.png", self.view.bounds.width/2 - 65, 93)
      self.addTextField("Your Name", name_tag, 43, 250)
      self.addTextField("Your Email", email_tag, 43, 310)
      self.addTextView("\n\n\n\n\nYour Message",message_tag,43,370)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        nameTextField = self.view.viewWithTag(name_tag) as! UITextField
        emailTextField = self.view.viewWithTag(email_tag) as! UITextField
        messageTextView = self.view.viewWithTag(message_tag) as! UITextView
        
        messageTextView.delegate = self
      
        emailTextField.keyboardType = .EmailAddress
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if messageTextView.textColor == UIColor.lightGrayColor() {
            messageTextView.text = ""
            messageTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if messageTextView.text == "" {
            
            messageTextView.text = "\n\n\n\n\nYour Message"
            messageTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    /*func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = !textView.text.isEmpty
    }*/
    // press return doesn dismiss the keyboard
  
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
