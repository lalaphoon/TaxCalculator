//
//  AboutViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-22.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        let ver : String = appVersion as! String
        let build : String = appBuildVersion as! String
        var version: String = "Version: \(ver).\(build)"
        self.addImage("icon.png", self.view.bounds.width/2-50, 100, 100, 100)
        self.view.addHeader("TaxPro", self.view.bounds.width/2, 220, 80, 20)
        self.view.addText("\(version)", self.view.bounds.width/2, 250, 280, 20)
        self.addImage("TITLE.png", self.view.bounds.width/2-80, self.view.bounds.height-150, 150, 35)
        self.view.addText("Contact Us: info@wtctax.ca", self.view.bounds.width/2-5, self.view.bounds.height-100, 250,35 )
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
