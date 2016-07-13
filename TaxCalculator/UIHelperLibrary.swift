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
}

