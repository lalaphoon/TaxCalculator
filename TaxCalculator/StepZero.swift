//
//  StepZero.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class StepZero: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.customOrangeColor()
        self.addLabel("I'm a page zero", self)
        self.addButton("test", "Clickme:", self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Clickme(sender: UIButton! ){
        print("Clicked me!")
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
