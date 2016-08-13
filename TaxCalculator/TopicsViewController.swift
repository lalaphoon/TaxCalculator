//
//  TopicsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {

    let INCOME = 1
    let DEDUCTION = 2
    let TAXCREDIT = 3
    let s = NSSelectorFromString("moveIntoNext:")
    
    var choice = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.addOrangeBorderButton("Income", s, 43, 207, self.view.bounds.width - (43*2), 67, INCOME)
        self.addOrangeBorderButton("Deduction", s, 43, 322, self.view.bounds.width - (43*2), 67, DEDUCTION)
        self.addOrangeBorderButton("Tax Credit", s, 43, 429, self.view.bounds.width - (43*2), 67, TAXCREDIT)
    }
    
    func moveIntoNext(sender: UIButton){
      choice = sender.tag
      performSegueWithIdentifier("MoveIntoSubTopics", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestinyVC : SubTopicsViewController = segue.destinationViewController as! SubTopicsViewController
        DestinyVC.choice = choice
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
