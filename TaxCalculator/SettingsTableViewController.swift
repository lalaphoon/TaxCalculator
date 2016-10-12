//
//  SettingsTableViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-06.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import Social

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        self.tableView.tableFooterView =  UIView()
       // self.tableView.backgroundColor = UIColor(red: 249/255.0, green: 235/255.0, blue: 210/255.0, alpha: 1.0)
        
        self.navigationItem.title = "Settings"
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return 1}
        else if section == 1 {return 2}
        else if section == 2 {return 3}
        else { return 0}
    }*/
    
    //Reference: sharing.......
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if indexPath.section  == 3 {
         print("sharing")
         let actionSheet = UIAlertController(title: "", message: "Share this app", preferredStyle: UIAlertControllerStyle.ActionSheet)
            // Configure a new action for sharing the note in Twitter.
            let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
                    let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    twitterComposeVC.setEditing(true, animated: true)
                    self.presentViewController(twitterComposeVC, animated: true, completion: nil)
                } else {
                    self.showAlertMessage("You are not logged in to your Twitter account")
                }
                
            }
            
            // Configure a new action to share on Facebook.
            let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                    let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    facebookComposeVC.setEditing(true, animated: true)
                    self.presentViewController(facebookComposeVC, animated: true, completion: nil)
                } else {
                    self.showAlertMessage("You are not connected to your Facebook account.")
                }
            }
            
            // Configure a new action to show the UIActivityViewController
            let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default) { (action) -> Void in
                //第一个参数是一个数组，里面包含了我们想要发送的内容
                //具体来说，如果我们只有一张图片，那么就不会显示「Add to reading list」!!!
                //Attach link here!
                let activityViewController = UIActivityViewController(activityItems: ["Share this app to your friends"], applicationActivities: nil)
                //activityViewController.excludedActivityTypes = [UIActivityTypeMail]
                self.presentViewController(activityViewController, animated: true, completion: nil)
            }
            
            
            let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
            }
            
            actionSheet.addAction(tweetAction)
            actionSheet.addAction(facebookPostAction)
            actionSheet.addAction(moreAction)
            actionSheet.addAction(dismissAction)
            
            presentViewController(actionSheet, animated: true, completion: nil)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
         return 15
        }
       
    }
    /*override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        headerView.tintColor = UIColor.blackColor()
        return headerView
    }*/

    
   /* override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        var cell = UITableViewCell()
        cell.textLabel!.font = UIFont(name: SMALLTITLE, size: 12)
        return cell
    }*/


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
