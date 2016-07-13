//
//  Library.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//
//Hopefully, it can help us to add componnets
import UIKit

extension UIViewController {
    //a test for adding a label
    func addLabel(what: String, _ myview: UIViewController){
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = what
        myview.view.addSubview(label)
    
    }
    func addButton(title: String, _ buttonaction:Selector, _ myview: UIViewController){
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .greenColor()
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        myview.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addTextField(myview: UIViewController){
        var txtField : UITextField = UITextField()
        txtField.frame = CGRectMake(50, 250, 100,50)
        txtField.backgroundColor = UIColor.grayColor()
        myview.view.addSubview(txtField)
    }
}


class customView: UIView {
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

