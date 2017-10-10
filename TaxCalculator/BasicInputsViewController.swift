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
    
    var menu : Menu!
    
    var c = Calculator(algorithm: RRSP.sharedInstance)
    
    
    func checkCalculation(){
     /*let start = String(self.category)+"-"+String(topic)+"-"+String(option)
         print("start is \(start)")
        if start == "1-1-1" {
           print("I'm in12")
        c = Calculator(algorithm: InterestIncome.sharedInstance)
        }*/
        
        c = Calculator(algorithm: menu.formula)
        print("Menu is \(menu.name)")
    }
    
   
    override func viewDidLoad(){
        super.viewDidLoad()
        self.scrollView = UIScrollView(frame: UIScreen.main.bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize =  CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
       // self.containerView = UIView()
        checkCalculation()
        self.containerView = c.initUI(self)
        //Add something for calculator...
        self.scrollView.addSubview(self.containerView)
        self.view.addSubview(scrollView)
        self.hideKeyboardWhenTappedAround()
        
        
    }
    func moveToNext(){
       // c.retrieveData()
     //   print("tabbed")
        if( c.checkBasicInput()){
          performSegue(withIdentifier: "MoveIntoProfile", sender: self)
        } 
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
        containerView.frame = CGRect(x: 0,y: 0,width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinyVC : ProfileViewController = segue.destination as! ProfileViewController
        DestinyVC.formula = c
        //DestinyVC.topic = topic
        //DestinyVC.option = option
    }
}
