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
    
    @IBOutlet weak var myWebView: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureWebView(){
        let termsURL = Bundle.main.url(forResource: "Terms", withExtension: "html")
        let requestObj = URLRequest(url: termsURL!)
        myWebView.backgroundColor = UIColor.white
        myWebView.loadRequest(requestObj)
    }
    //Unused textview
    /*
    func configureTextView(){
        let TP = TaxPro()
        let content : String = "Terms of Use \n\n" + TP.getTerms()
        Term.text = content
        Term.font = UIFont(name: THINFONT, size: 16)
        Term.textAlignment = .Justified
        Term.editable = false
    }
*/
}
