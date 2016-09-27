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
        cell.HeaderTitle.text = "Test"
        cell.Body.text = "Test"
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
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
