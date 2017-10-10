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
    fileprivate let image = UIImage(named: "star-large")!.withRenderingMode(.alwaysTemplate)
    fileprivate let topMessage = "Hi!"
    fileprivate let bottomMessage = "You havn't saved any records yet~"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Saved"
        savedTableView.delegate = self
        savedTableView.dataSource = self
        let cellCollNib = UINib(nibName: "ResultCell", bundle: Bundle.main)
        savedTableView.register(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordCells = CoreDataFetcher.fetch_records()
        savedTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RecordTableCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RecordTableCell
        cell.HeaderTitle.text = recordCells[indexPath.row].getTitle()
        cell.Body.text = recordCells[indexPath.row].getDescription()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recordCells.count == 0 {
            savedTableView.backgroundView?.isHidden = false
        } else {
            savedTableView.backgroundView?.isHidden = true
        }
        
        return recordCells.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           //numOfCells -= 1
           recordCells[indexPath.row].delete()
           recordCells.remove(at: indexPath.row)
           print("a record is deleting.....")
           tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        nextRecord = recordCells[indexPath.row]
        performSegue(withIdentifier: "gotoResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinyVC : SavedHistoryViewController = segue.destination as! SavedHistoryViewController
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
        HeaderTitle.textColor = UIColor.black
        Body.font = UIFont(name: SMALLTITLE, size: 17.0)
        Body.textColor = UIColor.gray
        iconImage.image = UIImage(named: "bulb_icon_small.png")
    }
    
    /*override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: false)
    }*/
}
