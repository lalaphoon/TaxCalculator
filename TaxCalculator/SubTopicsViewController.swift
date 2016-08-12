//
//  SubTopicsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-11.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class SubTopicsViewController: UIViewController {
    let INCOME = 1
    let DEDUCTION = 2
    let TAXCREDIT = 3
    var choice = Int()
    override func viewDidLoad() {
        initUI()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func initUI(){
        if choice == INCOME {
         self.addOrangeBorderButton("Employment0", "choiseEmployment", 43, 138, self.view.bounds.width - (43*2) , 53)
            
        }else if choice == DEDUCTION {
             self.addOrangeBorderButton("Employment1", "choiseEmployment", 43, 138, self.view.bounds.width - (43*2) , 53)
        
        }else if choice == TAXCREDIT {
         self.addOrangeBorderButton("Employment2", "choiseEmployment", 43, 138, self.view.bounds.width - (43*2) , 53)
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
