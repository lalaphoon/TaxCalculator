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
        //self.view.backgroundColor = UIColor.customGreenColor()
        addPages()
        self.addWhiteButton("Start", "Start:", 20, self.view.frame.size.height - 100, self.view.frame.size.width - 40 , 50)
       // self.addWhiteButton("Sign Up", "SignUp:", 20, (self.view.frame.size.height - 70),self)
        //self.addWhiteButton("Log In", "Login:", 200,(self.view.frame.size.height - 70),self )
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Start(sender: UIButton!){
        performSegueWithIdentifier("Start", sender: self)
    }
    
    func addPages(){
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! OnboardingPagesViewController
        self.pageViewController.view.frame = CGRectMake(0,30,self.view.frame.width, self.view.frame.size.height-40)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    func SignUp(sender: UIButton!){
        print("Sign up")
    }
    func Login(sender: UIButton!){
        print("Log in")
    }
    

}
