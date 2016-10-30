//
//  TopicsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let s = NSSelectorFromString("moveIntoNext:")
    var tableView: UITableView =  UITableView()
    let menu: [String] = Array(TaxMenu.keys)
    
   // @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var category = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Hide submenu
        /*if self.revealViewController() != nil {
            //self.navigationItem.leftBarButtonItem = menuButton
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/

        //initUI()
        //initForUI()
        initTableView()
        self.navigationItem.title = "Topics"
        // Do any additional setup after loading the view.
    }
   /* override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }*/
    
    func initTableView(){
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    
    }
    func initUI(){
        self.addOrangeBorderButton("Income", s, 43, 207, self.view.bounds.width - (43*2), 67, INCOME)
        self.addOrangeBorderButton("Deduction", s, 43, 322, self.view.bounds.width - (43*2), 67, DEDUCTION)
        self.addOrangeBorderButton("Tax Credit", s, 43, 429, self.view.bounds.width - (43*2), 67, TAXCREDIT)
    }
    func initForUI(){
        var pos_y = 207
        let distance = 105
        //let inset: CGFloat = -63 // move up by 63
        for i in TaxMenu.keys{
            self.addOrangeBorderButton(i, s, 43, CGFloat(pos_y) , self.view.bounds.width - (43*2), 67, TaxMenu[i]!)
            pos_y += distance
        }
    
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = menu[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.font = UIFont(name: SMALLTITLE, size: 17)
        //cell.backgroundColor = UIColor.yellowColor()
        //cell.tintColor = UIColor.customRedButton()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        category = TaxMenu[menu[indexPath.row]]!
        print(indexPath.row)
        print(menu[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("MoveIntoSubTopics", sender: self)
    }
    
    func moveIntoNext(sender: UIButton){
      category = sender.tag
      print("category is \(category)")
      performSegueWithIdentifier("MoveIntoSubTopics", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : SubMenuViewController = segue.destinationViewController as! SubMenuViewController
        DestinyVC.category = category
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
