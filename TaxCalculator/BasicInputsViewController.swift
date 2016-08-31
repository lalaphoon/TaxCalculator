//
//  BasicInputsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-26.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit
class BasicInputsViewController: UIViewController, UIScrollViewDelegate{
   
    var scrollView: UIScrollView!
    var containerView = UIView()
    
    var category = Int()
    var topic = Int()
    var option = Int()
    
    let c = Calculator(algorithm: RRSP.sharedInstance)
    override func viewDidLoad(){
        super.viewDidLoad()
        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize =  CGSizeMake(self.view.bounds.width, 667)
       // self.containerView = UIView()
        self.containerView = c.initUI(self)
        //Add something for calculator...
        self.scrollView.addSubview(self.containerView)
        self.view.addSubview(scrollView)
        self.hideKeyboardWhenTappedAround()
        
        
    }
    func moveToNext(){
       // c.retrieveData()
        performSegueWithIdentifier("MoveIntoProfile", sender: self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0,0,scrollView.contentSize.width, scrollView.contentSize.height)
    }
}
