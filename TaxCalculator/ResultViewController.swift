//
//  ResultViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UIScrollViewDelegate {
    
    var TP = TaxPro()
    
    var scrollView : UIScrollView!
    var containerView: UIView!
    
    var formula : Calculator!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.main.bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width , height: 550)
        
        self.containerView =  UIView()
        self.scrollView.isUserInteractionEnabled = true
        self.containerView.isUserInteractionEnabled = true
        
        self.scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        initContainerUI()

        // Do any additional setup after loading the view.
    }
 
    func initContainerUI(){
        let offset : CGFloat = -63
        
        //1.Setting up the title image
        containerView.addImage( "Title_completed.png", self.view.bounds.width/2 - 65,93 + offset)
        
        //2.setting up the instruction
        var str = formula.getInstruction()
        containerView.addText( str,self.view.bounds.width/2, 274 + offset, self.view.bounds.width-86, 100)
        
        //3.setting up the result for the green box
        var re = "$ " + TP.get2Digits(formula.getResult())
       // containerView.addGreenLabel(re, self.view.bounds.width/2, 345, self.view.bounds.width-86, 49)
        containerView.addLabelGreenButton(re, "viewProcess", 43, 325 + offset, self.view.bounds.width-86, 49, self)
        
        //4.setting up the tips
       // containerView.addText(c.getTip(), self.view.bounds.width/2, 440, self.view.bounds.width-86, 100)
       // containerView.addYellowButton("Tax Tip", "viewTip", 43, 420, 100, 50, self)
        containerView.addImageButton("Tax Tip", "viewTip", "bulb_icon_small.png", 43, 400 + offset, 130, 70, self)
        containerView.addImageButton("View Details", "viewProcess", "calculator_icon_small.png",40, 465 + offset, 180,70,self)
        //485
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ResultViewController.save))
        //5.Setting up the the start new calculat buttion
        containerView.addYellowButton("Start a new search", "StartNewCalculation", 90, 540 + offset, self.view.bounds.width - 180, 50, self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save(){
        //navigationItem.rightBarButtonItem?.title = "saved"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Saved", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ResultViewController.save))
        navigationItem.rightBarButtonItem?.isEnabled = false
        var xValues : [String]
        var yValues : [Double]
        var tableData : [[String]]
        (xValues,yValues,tableData) = formula.retrieveData()
        var r : Record = Record(title: "A Title..." , descrip: formula.getDefinition(), helpInstruction: formula.getTip())!
        var v  = [Value]()
        for index in 0..<xValues.count {
            let iv : Value = Value(key: xValues[index], value: yValues[index])!
            v.append(iv)
        }
        var td = [TableCellData]()
        for index in 0..<tableData.count {
            let itd : TableCellData = TableCellData(first: tableData[index][0], second: tableData[index][1], third: tableData[index][2], forth: tableData[index][3])!
           td.append(itd)
            
        }
        r.attachTableDataSet(td)
        r.attachValueSet(v)
        r.save()
        
    }
    func viewProcess(){
        performSegue(withIdentifier: "MoveIntoProcess", sender: self)
    }
    func viewTip(){
         performSegue(withIdentifier: "MoveIntoAfterResult", sender: self)
    }
    func StartNewCalculation() {
      print("cllicked!")
      //performSegueWithIdentifier("goBack", sender: self)
        navigationController?.popToRootViewController(animated: true)
       // navigationController?.popToViewController(HomeViewController, animated: true)
    //self.dismissViewControllerAnimated(false, completion: nil)
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveIntoAfterResult"{
        let DestinyVC : AfterResultViewController = segue.destination as! AfterResultViewController
        DestinyVC.formula = formula
        } else {
        let DesVC: ProcessViewController = segue.destination as! ProcessViewController
        DesVC.formula = formula
        }
        //DestinyVC.topic = topic
        //DestinyVC.option = option
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
