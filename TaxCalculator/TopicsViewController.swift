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
    
    var choice = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.addOrangeBorderButton("Income", "choiseIncome", 43, 207, self.view.bounds.width - (43*2), 67)
        self.addOrangeBorderButton("Deduction", "choiseDeduction", 43, 322, self.view.bounds.width - (43*2), 67)
        self.addOrangeBorderButton("Tax Credit", "choiseTaxCredit", 43, 429, self.view.bounds.width - (43*2), 67)
    }
    func choiseIncome() {
        choice = INCOME
        performSegueWithIdentifier("MoveIntoSubTopics", sender: self)
        
    }
    func choiseDeduction(){
        choice = DEDUCTION
        performSegueWithIdentifier("MoveIntoSubTopics", sender: self)
    }
    func choiseTaxCredit(){
        choice = TAXCREDIT
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
