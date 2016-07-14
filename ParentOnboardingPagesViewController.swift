//
//  ParentOnboardingPagesViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ParentOnboardingPagesViewController: UIViewController {
    
    
    var pageViewController : OnboardingPagesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customOrangeColor()
        addPages()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPages(){
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! OnboardingPagesViewController
        self.pageViewController.view.frame = CGRectMake(0,30,self.view.frame.width, self.view.frame.size.height-60)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    

}
