//
//  TableViewController.swift
//  HideStaticCells
//
//  Created by Mengyi LUO on 2016-12-03.
//  Copyright © 2016 lalaphoon. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    
    var pickerVisible = false
    @IBOutlet weak var toggle: UISwitch!

    @IBAction func toggleValueChanged(sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBOutlet weak var date: UILabel!


    @IBAction func dateChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        date.text = dateFormatter.stringFromDate(sender.date)
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == 1 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 && toggle.on == false {
            return 0.0
        }
        if indexPath.row == 2 {
          
                if toggle.on == false || pickerVisible == false {
                    return 0.0
                }
                return 165.0
            
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }


}
