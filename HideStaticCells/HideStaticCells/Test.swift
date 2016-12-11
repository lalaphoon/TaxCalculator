//
//  Test.swift
//  HideStaticCells
//
//  Created by Mengyi LUO on 2016-12-05.
//  Copyright © 2016 lalaphoon. All rights reserved.
//

import UIKit
import Foundation

class Test: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {

    
    @IBOutlet weak var tblExpandable: UITableView!
    var cellDescriptors = NSMutableArray()
    var visibleRowsPerSection = [[Int]]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
       // configureTableView()
       // loadCellDescriptors()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        
        loadCellDescriptors()
        print(cellDescriptors)
    }

    func configureTableView(){
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        tblExpandable.tableFooterView = UIView(frame: CGRectZero)
        
        tblExpandable.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        tblExpandable.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        tblExpandable.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        tblExpandable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        tblExpandable.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        tblExpandable.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    
    }
    func addTopicGroupCell() -> NSMutableArray{
        var guy = NSMutableArray()
        /*addNormalCell("Topic", what.count, guy)
        for i in what{
            addValueCell(i, guy)
        }*/
          guy.addObject(["additionalRows":0, "cellIdentifier":"idCellTextfield", "isExpandable": false, "isExpanded": false, "isVisible": true, "secondaryTitle":"", "primaryTitle":"Dividend Income", "value":""])
        guy.addObject(["additionalRows":0, "cellIdentifier":"idCellSwitch", "isExpandable": false, "isExpanded": false, "isVisible": true, "secondaryTitle":"", "primaryTitle":"Canadian Corporation", "value":""])
          guy.addObject(["additionalRows":2, "cellIdentifier":"idCellSwitch", "isExpandable": true, "isExpanded": false, "isVisible": true, "secondaryTitle":"", "primaryTitle":"Non-company Trade in Stockmarket", "value":""])
        guy.addObject(["additionalRows":0, "cellIdentifier":"idCellSwitch", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"it is in US", "value":""])
         guy.addObject(["additionalRows":0, "cellIdentifier":"idCellTextfield", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"Foreign taxes paid", "value":""])
        return guy
    }

    func loadCellDescriptors(){
        //if cellDescriptors.count < 2 {
            cellDescriptors.addObject(addTopicGroupCell())
        //}
        getIndicesOfVisibleRows()
        tblExpandable.reloadData()
        
    }
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()
            
            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            
            visibleRowsPerSection.append(visibleRows)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellDescriptors.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(currentCellDescriptor["cellIdentifier"] as! String, forIndexPath: indexPath) as! CustomCell
        
        if currentCellDescriptor["cellIdentifier"] as! String == "idCellNormal" {
            if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                cell.textLabel?.text = primaryTitle as? String
            }
            
            if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
                cell.detailTextLabel?.text = secondaryTitle as? String
                // cell.detailTextLabel?.text = "Test"
            }
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellTextfield" {
            cell.textField.placeholder = currentCellDescriptor["primaryTitle"] as? String
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSwitch" {
            cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
            
            let value = currentCellDescriptor["value"] as? String
            cell.swMaritalStatus.on = (value == "true") ? true : false
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellValuePicker" {
            cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSlider" {
            let value = currentCellDescriptor["value"] as! String
            cell.slExperienceLevel.value = (value as NSString).floatValue
        }
        
        cell.delegate = self
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case "idCellNormal":
            return 60.0
            
        case "idCellDatePicker":
            return 270.0
            
        default:
            return 60.0
        }
    }
    func dateWasSelected(selectedDateString: String) {
        let dateCellSection = 0
        let dateCellRow = 3
        
        cellDescriptors[dateCellSection][dateCellRow].setValue(selectedDateString, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func maritalStatusSwitchChangedState(isOn: Bool, parentCell: CustomCell) {
        let parentCellIndexPath = tblExpandable.indexPathForCell(parentCell)
        print(parentCellIndexPath?.row)
        let sth = parentCellIndexPath?.row
        let maritalSwitchCellSection = 0
        let maritalSwitchCellRow = Int(sth!)
        
        let valueToStore = (isOn) ? true : false
        let valueToDisplay = (isOn) ? "true" : "false"
        
       let indexOfTappedRow = visibleRowsPerSection[maritalSwitchCellSection][maritalSwitchCellRow]
        var array: NSMutableArray = cellDescriptors[maritalSwitchCellSection].mutableCopy() as! NSMutableArray
        var test : NSMutableDictionary = cellDescriptors[maritalSwitchCellSection][indexOfTappedRow].mutableCopy() as! NSMutableDictionary
        test.setValue(valueToStore, forKey: "isExpanded")
          test.setValue(valueToDisplay, forKey: "value")
        print("Should expanded")
        print(valueToStore)
        array.replaceObjectAtIndex(indexOfTappedRow, withObject: test)
        cellDescriptors[maritalSwitchCellSection] = array
        if maritalSwitchCellRow == 2 {
         array = cellDescriptors[maritalSwitchCellSection].mutableCopy() as! NSMutableArray
         test  = cellDescriptors[maritalSwitchCellSection][indexOfTappedRow+1].mutableCopy() as! NSMutableDictionary
        test.setValue(valueToStore, forKey: "isVisible")
        //print("Should expanded")
        array.replaceObjectAtIndex(indexOfTappedRow+1, withObject: test)
        cellDescriptors[maritalSwitchCellSection] = array
        
        array = cellDescriptors[maritalSwitchCellSection].mutableCopy() as! NSMutableArray
        test  = cellDescriptors[maritalSwitchCellSection][indexOfTappedRow+2].mutableCopy() as! NSMutableDictionary
        test.setValue(valueToStore, forKey: "isVisible")
        //print("Should expanded")
        array.replaceObjectAtIndex(indexOfTappedRow+2, withObject: test)
        cellDescriptors[maritalSwitchCellSection] = array
        }
        
        //cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow].setValue(valueToStore, forKey: "value")
        //cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow].setValue(valueToDisplay, forKey: "isExpanded")
          //print(cellDescriptors)
           getIndicesOfVisibleRows()
        tblExpandable.reloadData()
    }
    
    
    func textfieldTextWasChanged(newText: String, parentCell: CustomCell) {
        let parentCellIndexPath = tblExpandable.indexPathForCell(parentCell)
        
        let currentFullname = cellDescriptors[0][0]["primaryTitle"] as! String
        let fullnameParts = currentFullname.componentsSeparatedByString(" ")
        
        var newFullname = ""
        
        if parentCellIndexPath?.row == 1 {
            if fullnameParts.count == 2 {
                newFullname = "\(newText) \(fullnameParts[1])"
            }
            else {
                newFullname = newText
            }
        }
        else {
            newFullname = "\(fullnameParts[0]) \(newText)"
        }
        
        cellDescriptors[0][0].setValue(newFullname, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func sliderDidChangeValue(newSliderValue: String) {
        cellDescriptors[2][0].setValue(newSliderValue, forKey: "primaryTitle")
        cellDescriptors[2][1].setValue(newSliderValue, forKey: "value")
        
        tblExpandable.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
    }

    
}
