//
//  TopicsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {

    let s = NSSelectorFromString("moveIntoNext:")
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var category = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            //self.navigationItem.leftBarButtonItem = menuButton
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        //initUI()
        initForUI()
        
        // Do any additional setup after loading the view.
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
        var DestinyVC : SubTopicsViewController = segue.destinationViewController as! SubTopicsViewController
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
