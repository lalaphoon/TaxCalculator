//
//  TermsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-14.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import Foundation

class TermsViewController: UIViewController {
    
    var TP = TaxPro()
    @IBOutlet weak var Term: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let content : String = "Terms of Use \n\n" + TP.getTerms()
        Term.text = content
        Term.font = UIFont(name: THINFONT, size: 16)
        Term.textAlignment = .Justified
        Term.editable = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
