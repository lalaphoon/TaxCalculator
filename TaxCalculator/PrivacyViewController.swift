//
//  PrivacyViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-15.
//  Copyright © 2016 WTC Tax. All rights reserved.
//
//  Reference: https://makeapppie.com/2014/10/28/swift-swift-using-uiwebviews-in-swift/


import UIKit

class PrivacyViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configureWebView() {
        let privacyURL = Bundle.main.url(forResource: "privacy", withExtension: "html")
        let requestObj = URLRequest(url: privacyURL!)
        myWebView.loadRequest(requestObj)
        myWebView.backgroundColor = UIColor.white
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
