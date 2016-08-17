//
//  HistoryViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UIScrollViewDelegate {

    var scrollView : UIScrollView!
    var containerView :  UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 667)
        
        self.containerView =  UIView()
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        //self.view = self.scrollView
        
        //self.view.addGreenLabel("This is a text", 0, 200)
        containerView.addGreenLabel("This is a text", self.view.bounds.width/2, 200,self.view.bounds.width - 86, 49)
        // Do any additional setup after loading the view.
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
