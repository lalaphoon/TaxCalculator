//
//  AfterResultViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-27.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

class AfterResultViewController: UIViewController, UIScrollViewDelegate{
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    var formula : Calculator!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 1000)
        
        self.containerView =  UIView()
        self.scrollView.userInteractionEnabled = true
        self.containerView.userInteractionEnabled = true
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initTipUI()
    }
    func initTipUI(){
        let offset: CGFloat = -63
       containerView.addImage("Title_light.png", self.view.bounds.width/2 - 65,93 + offset)
       containerView.addHeader("Tax Tip:", self.view.bounds.width/2, 253 + offset, self.view.bounds.width-86,100)
       containerView.addText(formula.getTip(),self.view.bounds.width/2, 390 + offset, self.view.bounds.width-86, 300)
       containerView.addYellowButton("Get General Help", "goHelp", 43, 650 + offset, self.view.bounds.width - (43*2), 36, self)
    }
    func goHelp(){
        performSegueWithIdentifier("goHelp", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }


}
