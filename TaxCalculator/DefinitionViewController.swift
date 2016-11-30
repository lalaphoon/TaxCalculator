//
//  DefinitionViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-23.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import Foundation

class DefinitionViewController: UIViewController, UIScrollViewDelegate {

  //  var scrollView: UIScrollView!
  //  var containerView: UIView!
    
    var formula : Calculator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width, 650)
        
        self.containerView = UIView()
        self.scrollView.userInteractionEnabled = true
        self.containerView.userInteractionEnabled = true
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        */
        initDefinitionUI()
        // Do any additional setup after loading the view.
    }
    func initDefinitionUI(){
        let offset: CGFloat = 0
       self.view.addImage("Title_openedbook.png",self.view.bounds.width/2 - 65 + offset, 93 + offset)
        self.view.addHeader("General Help", self.view.bounds.width/2, 243 + offset, self.view.bounds.width-86, 100)
        //containerView.addText(formula.getDefinition(), self.view.bounds.width/2, 400 + offset, self.view.bounds.width-86,300, NSTextAlignment.Left)
        self.view.addTextView(formula.getDefinition(), 1, 43, 280 + offset, self.view.bounds.width-86, self.view.bounds.height-280-30-70)
        var text : UITextView = self.view.viewWithTag(1) as! UITextView
        text.editable = false
        self.view.addYellowButton("Start a new search", "StartNewCalculation", 90, self.view.bounds.height - 30 - 70, self.view.bounds.width - 180, 40, self)
    
    }
    func StartNewCalculation() {
        print("cllicked!")
        //performSegueWithIdentifier("goBack", sender: self)
        navigationController?.popToRootViewControllerAnimated(true)
        // navigationController?.popToViewController(HomeViewController, animated: true)
        //self.dismissViewControllerAnimated(false, completion: nil)
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
