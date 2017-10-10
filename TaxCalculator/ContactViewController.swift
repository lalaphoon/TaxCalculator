//
//  ContactViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-24.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController,UIScrollViewDelegate, UITextViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var mainMenu: UIBarButtonItem!
    var scrollView : UIScrollView!
    var containerView : UIView!
    
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var subjectTextField = UITextField()
    var messageTextView =  UITextView()
    
    let name_tag : Int = 1
    let email_tag : Int = 2
    let message_tag : Int = 3
    let subject_tag : Int = 4
    

    func initUI(){
        
        //=====================This is for self.view=============================
        self.addImage("Title_message.png", self.view.bounds.width/2 - 65, 93)
        self.addTextField("Your Name", name_tag, 43, 250)
        //self.addTextField("Your Email", email_tag, 43, 310)
        self.addTextField("Subject", subject_tag, 43, 310)
        self.addTextView("\n\n\n\nMessage",message_tag,43,370)
        self.addYellowButton("Send", "sendEmail", 266, 567, self.view.bounds.width - (43 * 2), 36)
        //======================This is the end for self.view======================

    }
    func initContainerUI(){
        //=====================This is for container view==========================
        let num: CGFloat = 63
        containerView.addImage("Title_message.png", self.view.bounds.width/2 - 65, 93 - num)
        containerView.addTextField("Your Name", name_tag, 43, 250 - num, self.view.bounds.width - (43*2))
        //self.addTextField("Your Email", email_tag, 43, 310)
        containerView.addTextField("Subject", subject_tag, 43, 310 - num, self.view.bounds.width - (43*2))
        containerView.addTextView("\n\n\n\nMessage",message_tag, 43 , 370 - num, self.view.bounds.width - (43*2))
        containerView.addYellowButton("Send", "sendEmail", 43, 567 - num, self.view.bounds.width - (43*2), 36, self)
        //=====================This is the end for container view===================
    }
    func retrieveDataFromView(){
        //====================This is for self.view==========================
        
        nameTextField = self.view.viewWithTag(name_tag) as! UITextField
        //emailTextField = self.view.viewWithTag(email_tag) as! UITextField
        subjectTextField = self.view.viewWithTag(subject_tag) as! UITextField
        messageTextView = self.view.viewWithTag(message_tag) as! UITextView

        //=======================This is the end for self.view=================
    }
    func retrieveDataFromContainer(){
        //====================This is for container.view=======================
        
        nameTextField = self.containerView.viewWithTag(name_tag) as! UITextField
        //emailTextField = self.containerView.viewWithTag(email_tag) as! UITextField
        subjectTextField = self.containerView.viewWithTag(subject_tag) as! UITextField
        messageTextView = self.containerView.viewWithTag(message_tag) as! UITextView
        
        //====================This is the end for container view===================
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.main.bounds)
        //self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width ,height: 550)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        //self.view = self.scrollView
        
        initContainerUI()
        retrieveDataFromContainer()
        
        //initUI()
        //retrieveDataFromView()
     
        nameTextField.delegate = self
       // emailTextField.delegate = self
        subjectTextField.delegate = self
        messageTextView.delegate = self
      
        //emailTextField.keyboardType = .EmailAddress
        
        // Do any additional setup after loading the view.
       // self.automaticallyAdjustsScrollViewInsets = false;
        self.hideKeyboardWhenTappedAround()
        if self.revealViewController() != nil {
            mainMenu.target = self.revealViewController()
            mainMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    //if we comment this out, we will not input anything...
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.view.endEditing(true) /////<-------------? 
        self.containerView.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if messageTextView.textColor == UIColor.lightGray {
            messageTextView.text = ""
            messageTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text == "" {
            
            messageTextView.text = "\n\n\n\nYour Message"
            messageTextView.textColor = UIColor.lightGray
        }
    }
    func sendEmail(){
        print("Sending an email...")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate =  self
        mailComposerVC.setToRecipients(["lalaphoon@gmail.com", "will@wtctax.ca"])
        mailComposerVC.setSubject(subjectTextField.text!)
        mailComposerVC.setMessageBody(messageTextView.text! + "\n\n" + nameTextField.text!, isHTML: false)
        return mailComposerVC
    }
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle:  UIAlertControllerStyle.alert)
    }
    func sendAlert(_ alertTitle : String, alertMessage : String){
       let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled mail")
            sendAlert("Sending Cancelled", alertMessage: "You have cancelled sending your email!")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
            sendAlert("Mail Sent", alertMessage: "Your email has been sent to us!\n Thank you very much!")
        case MFMailComposeResult.saved.rawValue:
            print("You saved a draft of this email")
            break;
        default:
            break
        }
        
    }
    /*func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = !textView.text.isEmpty
    }*/
    
    // press return doesn dismiss the keyboard - This is for Done button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
