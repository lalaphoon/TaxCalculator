//
//  CalculatorViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-14.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //initEverything()
        self.addTextField()
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initEverything(){
        //self.addBackgroundImage("background.jpg", self)
        self.view.addBackground("background.jpg")
        self.view.darken(60)
        //self.addBlackLayer(self)
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
