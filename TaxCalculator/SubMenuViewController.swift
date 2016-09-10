//
//  SubMenuViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-08.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit
class SubMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate{
    // MARK: IBOutlet Properties
    
    @IBOutlet weak var tblExpandable: UITableView!
    
    
    // MARK: Variables
    
    //var cellDescriptors : NSMutableArray!
    var cellDescriptors = NSMutableArray()
    var myNewNSMutableArray = NSMutableArray()
    var visibleRowsPerSection = [[Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        
        loadCellDescriptors()
        self.addYellowButton("Next", "MovetoNext", 43, tblExpandable.bounds.height + 10, self.view.bounds.width-86, 36)
        
        print(cellDescriptors)
    }
    
    func MovetoNext(){
        print(cellDescriptors)
        var array: NSMutableArray = cellDescriptors[0].mutableCopy() as! NSMutableArray
       // var test : NSMutableDictionary = cellDescriptors[0][indexOfTappedRow].mutableCopy() as! NSMutableDictionary
        for item in array {
            var m : NSMutableDictionary = item.mutableCopy() as! NSMutableDictionary
            if m["additionalRows"] as! Int != 0 {
                print(m["primaryTitle"] as! String)
            }
        }
        print("clicked")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom Functions
    
    func configureTableView() {
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
    
    func addNormalCell(Title: String, _ child: Int, _ guy: NSMutableArray){
      guy.addObject(["additionalRows":child, "cellIdentifier":"idCellNormal", "isExpandable": true, "isExpanded": false, "isVisible": true, "secondaryTitle":Title, "primaryTitle":"", "value":""])
    }
    func addValueCell(Title: String, _ guy:  NSMutableArray){
          guy.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":Title, "value":""])
    }
    func addTopicGroupCell(category: Int) -> NSMutableArray{
        var guy = NSMutableArray()
       // myNewNSMutableArray.removeAllObjects()
        if category == INCOME {
            addNormalCell("Topic", Income_subMenu.count,guy)
            for i in Income_subMenu.keys {
                addValueCell(i, guy)
            }
        }
        return guy
    }
    func addOptionGroupCell(){
        
    }
    
    func loadCellDescriptors() {
        
        /*
        if let path = NSBundle.mainBundle().pathForResource("CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)!
            getIndicesOfVisibleRows()
            tblExpandable.reloadData()
        }*/
        /* myNewNSMutableArray.addObject(["additionalRows":2, "cellIdentifier":"idCellNormal", "isExpandable": true, "isExpanded": false, "isVisible": true, "secondaryTitle":"Title", "primaryTitle":"", "value":""])
        myNewNSMutableArray.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"hello", "value":""])
        myNewNSMutableArray.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"world", "value":""])
         myNewNSMutableArray.addObject(["additionalRows":3, "cellIdentifier":"idCellNormal", "isExpandable": true, "isExpanded": false, "isVisible": true, "secondaryTitle":"Title2", "primaryTitle":"", "value":""])
         myNewNSMutableArray.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"Hello", "value":""])
         myNewNSMutableArray.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"hello", "value":""])
         myNewNSMutableArray.addObject(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":"hello", "value":""])*/
        
        //addTopicGroupCell(INCOME)
        
        cellDescriptors.addObject(addTopicGroupCell(INCOME))
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
    
    
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }
    
    
    // MARK: UITableView Delegate and Datasource Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       // if cellDescriptors != nil {
            return cellDescriptors.count
       // }
       // else {
        //    return 0
       // }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal"
            
        case 1:
            return "Preferences"
            
        default:
            return "Work Experience"
        }
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
            return 44.0
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                shouldExpandAndShowSubRows = true
            }
            //https://www.appcoda.com/expandable-table-view/
            var array: NSMutableArray = cellDescriptors[indexPath.section].mutableCopy() as! NSMutableArray
            var test : NSMutableDictionary = cellDescriptors[indexPath.section][indexOfTappedRow].mutableCopy() as! NSMutableDictionary
            test.setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            array.replaceObjectAtIndex(indexOfTappedRow, withObject: test)
            cellDescriptors[indexPath.section] = array
           // print("I'm here")
            
          //  cellDescriptors[indexPath.section][indexOfTappedRow].setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
               // cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
                var array: NSMutableArray = cellDescriptors[indexPath.section].mutableCopy() as! NSMutableArray
                var test : NSMutableDictionary = cellDescriptors[indexPath.section][i].mutableCopy() as! NSMutableDictionary
                test.setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
                array.replaceObjectAtIndex(i, withObject: test)
                cellDescriptors[indexPath.section] = array
            }
        }
        else {
            if cellDescriptors[indexPath.section][indexOfTappedRow]["cellIdentifier"] as! String == "idCellValuePicker" {
                var indexOfParentCell: Int!
                
                for var i=indexOfTappedRow - 1; i>=0; --i {
                    if cellDescriptors[indexPath.section][i]["isExpandable"] as! Bool == true {
                        indexOfParentCell = i
                        break
                    }
                }
                
                cellDescriptors[indexPath.section][indexOfParentCell].setValue((tblExpandable.cellForRowAtIndexPath(indexPath) as! CustomCell).textLabel?.text, forKey: "primaryTitle")
                cellDescriptors[indexPath.section][indexOfParentCell].setValue(false, forKey: "isExpanded")
                
               
                for i in (indexOfParentCell + 1)...(indexOfParentCell + (cellDescriptors[indexPath.section][indexOfParentCell]["additionalRows"] as! Int)) {
                    cellDescriptors[indexPath.section][i].setValue(false, forKey: "isVisible")
                }
                
                //cellDescriptors.removeAllObjects()
                cellDescriptors.addObject(addTopicGroupCell(INCOME))
                getIndicesOfVisibleRows()
                tblExpandable.reloadData()
            }
        }
        
        getIndicesOfVisibleRows()
       // tblExpandable.reloadData()
        tblExpandable.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
    // MARK: CustomCellDelegate Functions
    //Warning: setValue forKey shouldn't be working here, we have to use a NSMutableDictionary instead
    
    func dateWasSelected(selectedDateString: String) {
        let dateCellSection = 0
        let dateCellRow = 3
        
        cellDescriptors[dateCellSection][dateCellRow].setValue(selectedDateString, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func maritalStatusSwitchChangedState(isOn: Bool) {
        let maritalSwitchCellSection = 0
        let maritalSwitchCellRow = 6
        
        let valueToStore = (isOn) ? "true" : "false"
        let valueToDisplay = (isOn) ? "Married" : "Single"
        
        cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow].setValue(valueToStore, forKey: "value")
        cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow - 1].setValue(valueToDisplay, forKey: "primaryTitle")
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