//
//  SettingsTableViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-06.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import Social
import MessageUI

class SettingsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let sharingTitle: String = "Let's use TaxPro"
    let sharingImage: UIImage = UIImage(named: "star-large.png")!
    let sharingURL: URL = URL(string: "www.lalaphoon.me")!
    
    
    
    let messageTitle: String = "TaxPro-Feedback"
    let messageBody: String = "\n\n\n System Version：\(SYSTEMVERSION )\n Device Model：\(modelName)"
    ///let messageBody: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        self.tableView.tableFooterView =  UIView()
       // self.tableView.backgroundColor = UIColor(red: 249/255.0, green: 235/255.0, blue: 210/255.0, alpha: 1.0)
        
        self.navigationItem.title = "Settings"
        
        
        //These code was used for submenu
        /*if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            sendEmail()
        }
        else if indexPath.section  == 3 && indexPath.row == 0 {
         print("sharing")
         sharing()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
         return 15
        }
       
    }
    //==================================================Helpers===============================================
    //Reference: sharing.......
    func showAlertMessage(_ message: String!) {
        let alertController = UIAlertController(title: "Accounts", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    func sharing() {
        let actionSheet = UIAlertController(title: "", message: "Share TaxPro to your friends!", preferredStyle: UIAlertControllerStyle.actionSheet)
        // Configure a new action for sharing the note in Twitter.
        let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterComposeVC?.setInitialText(self.sharingTitle)
                twitterComposeVC?.add(self.sharingImage)
                twitterComposeVC?.add(self.sharingURL)
                self.present(twitterComposeVC!, animated: true, completion: nil)
            } else {
                self.showAlertMessage("You are not logged in to your Twitter account")
            }
            
        }
        
        // Configure a new action to share on Facebook.
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
               // facebookComposeVC.setEditing(true, animated: true)
                facebookComposeVC?.setInitialText(self.sharingTitle)
                facebookComposeVC?.add(self.sharingImage)
                facebookComposeVC?.add(self.sharingURL)
                self.present(facebookComposeVC!, animated: true, completion: nil)
            } else {
                self.showAlertMessage("You are not connected to your Facebook account.")
            }
        }
        
        // Configure a new action to show the UIActivityViewController
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.default) { (action) -> Void in
            //第一个参数是一个数组，里面包含了我们想要发送的内容
            //具体来说，如果我们只有一张图片，那么就不会显示「Add to reading list」!!!
            //Attach link here!
            let activityViewController = UIActivityViewController(activityItems: ["Share this app to your friends"], applicationActivities: nil)
            //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    //=======================Sending Message=============================
    func sendEmail(){
        print("Sending an email...")
        print(self.messageBody)
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
        mailComposerVC.setSubject(self.messageTitle)
        mailComposerVC.setMessageBody(self.messageBody, isHTML: false)
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
//=======================================================================================================
    
   
   

}
