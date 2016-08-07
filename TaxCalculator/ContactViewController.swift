//
//  ContactViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-24.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var subjectTextField = UITextField()
    var messageTextView =  UITextView()
    
    let name_tag : Int = 1
    let email_tag : Int = 2
    let message_tag : Int = 3
    let subject_tag : Int = 4
    

    func initUI(){
      self.addImage("Title_message.png", self.view.bounds.width/2 - 65, 93)
      self.addTextField("Your Name", name_tag, 43, 250)
      //self.addTextField("Your Email", email_tag, 43, 310)
        self.addTextField("Your Subject", subject_tag, 43, 310)
      self.addTextView("\n\n\n\nYour Message",message_tag,43,370)
      self.addYellowButton("Send", "sendEmail", 266, 567, 87, 36)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        nameTextField = self.view.viewWithTag(name_tag) as! UITextField
       // emailTextField = self.view.viewWithTag(email_tag) as! UITextField
        subjectTextField = self.view.viewWithTag(subject_tag) as! UITextField
        messageTextView = self.view.viewWithTag(message_tag) as! UITextView
        
        nameTextField.delegate = self
       // emailTextField.delegate = self
        subjectTextField.delegate = self
        messageTextView.delegate = self
      
        //emailTextField.keyboardType = .EmailAddress
        
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false;
       
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
            
            messageTextView.text = "\n\n\n\nYour Message"
            messageTextView.textColor = UIColor.lightGrayColor()
        }
    }
    func sendEmail(){
        print("Sending an email...")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate =  self
        mailComposerVC.setToRecipients(["lalaphoon@gmail.com"])
        mailComposerVC.setSubject(subjectTextField.text!)
        mailComposerVC.setMessageBody(messageTextView.text! + "\n\n" + nameTextField.text!, isHTML: false)
        return mailComposerVC
    }
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle:  UIAlertControllerStyle.Alert)
    }
    func sendAlert(alertTitle : String, alertMessage : String){
       let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled mail")
            sendAlert("Sending Cancelled", alertMessage: "You have cancelled sending your email!")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
            sendAlert("Mail Sent", alertMessage: "Your email has been sent to us!\n Thank you very much!")
        case MFMailComposeResultSaved.rawValue:
            print("You saved a draft of this email")
            break;
        default:
            break
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
