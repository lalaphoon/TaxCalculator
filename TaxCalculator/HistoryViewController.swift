//
//  HistoryViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    
    @IBOutlet weak var savedTableView: UITableView!
    let reuseIdentifier = "ResultCell"
    var numOfCells = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTableView.delegate = self
        savedTableView.dataSource = self
        let cellCollNib = UINib(nibName: "ResultCell", bundle: NSBundle.mainBundle())
        savedTableView.registerNib(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
        savedTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RecordTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecordTableCell
        cell.HeaderTitle.text = "Interest Income"
        cell.Body.text = "A contribution of $123.00 of will get a ..."
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfCells
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           numOfCells -= 1
           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("gotoResult", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : SavedHistoryViewController = segue.destinationViewController as! SavedHistoryViewController
       // DestinyVC.formula = Calculator(algorithm: RRSP.sharedInstance)
       // DestinyVC.formula.setProfile(1234.00, province: "Ontario")
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
class RecordTableCell : UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var HeaderTitle: UILabel!
    @IBOutlet weak var Body: UILabel!
  
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        HeaderTitle.font = UIFont(name: BIGTITLE, size: 27.0)
        HeaderTitle.textColor = UIColor.blackColor()
        Body.font = UIFont(name: SMALLTITLE, size: 17.0)
        Body.textColor = UIColor.grayColor()
        iconImage.image = UIImage(named: "bulb_icon_small.png")
    }
    
    /*override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: false)
    }*/
}
