//
//  InputsViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class InputsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var scrollview : UIScrollView!
    var containerView : UIView!
    var option = UIPickerView()
    var dividenIncome = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
