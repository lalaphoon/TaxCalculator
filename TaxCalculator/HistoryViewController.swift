//
//  HistoryViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
//reference: core data and uitableview: http://www.starming.com/index.php?v=index&view=30
//           core data : http://blog.csdn.net/yamingwu/article/details/42215541
//           core data relationship: http://www.jianshu.com/p/8e3b64f16fc3
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var savedTableView: UITableView!
    let reuseIdentifier = "ResultCell"
    var recordCells = [Record]()
    //next Record is used to transfer record
    var nextRecord : Record!
   // @IBOutlet weak var mainMenu: UIBarButtonItem!
    private let image = UIImage(named: "star-large")!.imageWithRenderingMode(.AlwaysTemplate)
    private let topMessage = "Hi!"
    private let bottomMessage = "You havn't saved any records yet~"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite"
        savedTableView.delegate = self
        savedTableView.dataSource = self
        let cellCollNib = UINib(nibName: "ResultCell", bundle: NSBundle.mainBundle())
        savedTableView.registerNib(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
        savedTableView.tableFooterView = UIView()
        recordCells = CoreDataFetcher.fetch_records()
        setupEmptyBackgroundView()
        
        //This is used to hide submenu
        /*
        if self.revealViewController() != nil {
            mainMenu.target = self.revealViewController()
            mainMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordCells = CoreDataFetcher.fetch_records()
        savedTableView.reloadData()
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
        cell.HeaderTitle.text = recordCells[indexPath.row].getTitle()
        cell.Body.text = recordCells[indexPath.row].getDescription()
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recordCells.count == 0 {
            savedTableView.backgroundView?.hidden = false
        } else {
            savedTableView.backgroundView?.hidden = true
        }
        
        return recordCells.count
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           //numOfCells -= 1
           recordCells[indexPath.row].delete()
           recordCells.removeAtIndex(indexPath.row)
           print("a record is deleting.....")
           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        nextRecord = recordCells[indexPath.row]
        performSegueWithIdentifier("gotoResult", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : SavedHistoryViewController = segue.destinationViewController as! SavedHistoryViewController
        DestinyVC.record = nextRecord
    }
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.savedTableView.backgroundView = emptyBackgroundView
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
