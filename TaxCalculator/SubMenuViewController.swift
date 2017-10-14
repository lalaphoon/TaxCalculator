//
//  SubMenuViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-08.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit
//reference: https://www.appcoda.com/expandable-table-view/
class SubMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate{
    // MARK: IBOutlet Properties
    
    @IBOutlet weak var tblExpandable: UITableView!
    
    // MARK: Variables
    
    //var cellDescriptors : NSMutableArray!
    var cellDescriptors = NSMutableArray()
    var myNewNSMutableArray = NSMutableArray()
    var visibleRowsPerSection = [[Int]]()
    let TP =  TaxPro()
    var Topics = [String: Int]()
    var category : Int!
    var topic : Int = 0
    var option : Int = 0
    var TopicsChanged: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.category = INCOME
        self.Topics = TP.getTopics_IDByCategory(self.category)
        TopicsChanged = false
        //  self.addYellowButton("Next", "MoveIntoNext", 43, tblExpandable.bounds.height + 16, self.view.bounds.width-86, 36)
        self.addYellowButton("Next", "MoveIntoNext",43, self.view.bounds.height - 100, self.view.bounds.width-86,36)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        
        loadCellDescriptors()
        
        //print(cellDescriptors)
    }
    func showUpAlert(_ message: String){
        let alertController = UIAlertController(title: "Missing!",
            message: message, preferredStyle: .alert )
        //let okAction = UIAlertAction(title:"OK", style:., handler:nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func MoveIntoNext(){
       // print(cellDescriptors)
    //    var array: NSMutableArray = (cellDescriptors[0] as AnyObject).mutableCopy() as! NSMutableArray
        var array:NSMutableArray = cellDescriptors[0] as! NSMutableArray
        for item in array {
            var m : NSMutableDictionary = item as! NSMutableDictionary
            if m["cellIdentifier"] as! String == "idCellNormal" {
               // print(m["primaryTitle"] as! String)
                if (((m["primaryTitle"] as! String).isEqual(""))) {
                  
                   //self.tblExpandable.addWarningButton("Please give input for topic", "hideButton:", self.tblExpandable.bounds.width/2, self.tblExpandable.bounds.height/2-200, 300, 56,self, 1)
                  
                    showUpAlert("Please give input for Topic")
                   return
                }else {
                  // print(m["primaryTitle"])
                   self.topic = self.Topics[m["primaryTitle"] as! String]!
                }
            }
        }
        if cellDescriptors.count > 1 {
            array = cellDescriptors[1]  as! NSMutableArray
            for item in array {
                var m : NSMutableDictionary = item  as! NSMutableDictionary
                if m["cellIdentifier"] as! String == "idCellNormal" {
                    if (((m["primaryTitle"] as! String).isEqual(""))) {
                    
                    showUpAlert("Please give input for Subtopic")
                    return
                    } else {
                        
                        self.option = TP.lookForMenuID(self.category, self.topic, m["primaryTitle"] as! String)
                   
                    }
                }
            }

        }
            performSegue(withIdentifier: "MoveIntoInputs", sender: self)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom Functions
    
    func configureTableView() {
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        tblExpandable.tableFooterView = UIView(frame: CGRect.zero)
        
        tblExpandable.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        tblExpandable.register(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        tblExpandable.register(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        tblExpandable.register(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        tblExpandable.register(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        tblExpandable.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
       
    }
    
    func addNormalCell(_ Title: String, _ child: Int, _ guy: NSMutableArray){
      guy.add(["additionalRows":child, "cellIdentifier":"idCellNormal", "isExpandable": true, "isExpanded": false, "isVisible": true, "secondaryTitle":Title, "primaryTitle":"", "value":""])
    }
    
    func addValueCell(_ Title: String, _ guy:  NSMutableArray){
          guy.add(["additionalRows":0, "cellIdentifier":"idCellValuePicker", "isExpandable": false, "isExpanded": false, "isVisible": false, "secondaryTitle":"", "primaryTitle":Title, "value":""])
    }
    
    func addTopicGroupCell(_ what: [String]) -> NSMutableArray{
        let guy = NSMutableArray()
        addNormalCell("Topic", what.count, guy)
        for i in what{
            addValueCell(i, guy)
        }
        return guy
    }
    
    func addOptionGroupCell() -> NSMutableArray{
        var guy = NSMutableArray()
        var array: NSMutableArray = cellDescriptors[0]  as! NSMutableArray
        var topic_name : String!
        // var test : NSMutableDictionary = cellDescriptors[0][indexOfTappedRow].mutableCopy() as! NSMutableDictionary
        for item in array {
            var m : NSMutableDictionary = item  as! NSMutableDictionary
            if m["cellIdentifier"] as! String == "idCellNormal" {
                topic_name = m["primaryTitle"] as! String
            }
        }
        var topic_id = self.Topics[topic_name]
        // myNewNSMutableArray.removeAllObjects()
        var list = TP.lookForOptions(self.category, topic_id!)
            addNormalCell("Subtopic", list.count,guy)
            for i in list {
                addValueCell(i, guy)
            }
        return guy
    }
   
    
    func loadCellDescriptors() {
        
        /*
        if let path = NSBundle.mainBundle().pathForResource("CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)!
            getIndicesOfVisibleRows()
            tblExpandable.reloadData()
        }*/
        if cellDescriptors.count < 2 {
        cellDescriptors.add(addTopicGroupCell(Array(self.Topics.keys)))
        }
        getIndicesOfVisibleRows()
        tblExpandable.reloadData()
    }
    
    
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        //print(cellDescriptors)
        for currentSectionCells in cellDescriptors {
            print("printing cell")
            print(currentSectionCells)
            var visibleRows = [Int]()
            var i : Int = 0
            for row in 0...((currentSectionCells as AnyObject).count - 1) {
                if (currentSectionCells as AnyObject).objectAt(row)["isVisible"] as! Bool == true {
                   // print("the current i is \(i)")
                    visibleRows.append(row)
                }
            }
            
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    
    func getCellDescriptorForIndexPath(_ indexPath: IndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = (cellDescriptors[indexPath.section] as! NSMutableArray)[indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }
    
    
    // MARK: UITableView Delegate and Datasource Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // if cellDescriptors != nil {
        
            return cellDescriptors.count
       // }
       // else {
        //    return 0
       // }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return visibleRowsPerSection[section].count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Please select a Topic"
            
        case 1:
            return "Please choose an Subtopic"
            
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: currentCellDescriptor["cellIdentifier"] as! String, for: indexPath) as! CustomCell
        
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
            cell.swMaritalStatus.isOn = (value == "true") ? true : false
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        
        if (cellDescriptors[indexPath.section] as! [[String: AnyObject]])[indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if (cellDescriptors[indexPath.section] as! [[String: AnyObject]])[indexOfTappedRow]["isExpanded"] as! Bool == false {
                shouldExpandAndShowSubRows = true
            }
            //https://www.appcoda.com/expandable-table-view/
            print("the indexpath section is  -------->   \(indexPath.section)")
            var array: NSMutableArray = cellDescriptors[indexPath.section] as! NSMutableArray
            
            print("the array count is \(array.count)")
            print("the indexOfTappedRow is      ->   \(indexOfTappedRow)")
            /*
            var test : NSMutableDictionary = (cellDescriptors[indexPath.section] as! NSMutableArray)[indexOfTappedRow] as! NSMutableDictionary
            test.setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            array.replaceObject(at: indexOfTappedRow, with: test)
            cellDescriptors[indexPath.section] = array
            */
            
            
            
            var test : [String: AnyObject] = (cellDescriptors[indexPath.section] as! NSMutableArray)[indexOfTappedRow] as! [String: AnyObject]
            
           // test.setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            test["isExpanded"] = shouldExpandAndShowSubRows as AnyObject
            array.replaceObject(at: indexOfTappedRow, with: test)
            cellDescriptors[indexPath.section] = array
            
            
            
            // ((cellDescriptors[indexPath.section] as! NSMutableArray)[indexOfTappedRow] as AnyObject).setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")

        
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + ((cellDescriptors[indexPath.section] as! [[String:AnyObject]])[indexOfTappedRow]["additionalRows"] as! Int)) {
               // cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
                var array: NSMutableArray = cellDescriptors[indexPath.section] as! NSMutableArray
                /*
                var test : NSMutableDictionary = (cellDescriptors[indexPath.section] as! [[String:AnyObject]])[i] as! NSMutableDictionary
                test.setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
                array.replaceObject(at: i, with: test)
                cellDescriptors[indexPath.section] = array*/
                
                
                var test : [String: AnyObject] = (cellDescriptors[indexPath.section] as! NSMutableArray)[i] as! [String: AnyObject]
                test["isVisible"] = shouldExpandAndShowSubRows as AnyObject
                array.replaceObject(at: i, with: test)
                cellDescriptors[indexPath.section] = array
                
                
                
            }
            
        }
        else {
            
            if (cellDescriptors[indexPath.section] as! [[String: AnyObject]])[indexOfTappedRow]["cellIdentifier"] as! String == "idCellValuePicker" {
                var indexOfParentCell: Int!
                if indexPath.section == 0 {
                    TopicsChanged = true
                }
                
                
                for i in (0...indexOfTappedRow - 1).reversed(){
                    if (cellDescriptors[indexPath.section] as! [[String:AnyObject]])[i]["isExpandable"] as! Bool == true {
                        indexOfParentCell = i
                        break
                    }
                }
                
                ((cellDescriptors[indexPath.section] as! NSMutableArray)[indexOfParentCell] as AnyObject).setValue((tblExpandable.cellForRow(at: indexPath) as! CustomCell).textLabel?.text, forKey: "primaryTitle")
                ((cellDescriptors[indexPath.section] as! NSMutableArray) [indexOfParentCell] as AnyObject).setValue(false, forKey: "isExpanded")
                
               
                for i in (indexOfParentCell + 1)...(indexOfParentCell + ((cellDescriptors[indexPath.section] as! [[String:AnyObject]])[indexOfParentCell]["additionalRows"] as! Int)) {
                    ((cellDescriptors[indexPath.section] as! NSMutableArray)[i] as AnyObject).setValue(false, forKey: "isVisible")
                }
                
                //================Adding Additional cell===================
                if category != TAXCREDIT {
                if cellDescriptors.count > 1 {
                    if TopicsChanged == true {
                        cellDescriptors.removeLastObject()
                        cellDescriptors.add(addOptionGroupCell())
                    }
                } else {
                print("Adding a table cell")
                cellDescriptors.add(addOptionGroupCell())
                }
                getIndicesOfVisibleRows()
                tblExpandable.reloadData()
                TopicsChanged = false
                }
                //===========================================================
            }
        }
        
        getIndicesOfVisibleRows()
        tblExpandable.reloadSections(IndexSet(integer: indexPath.section), with: UITableViewRowAnimation.fade)
    }
    
    
    // MARK: CustomCellDelegate Functions
    //Warning: setValue forKey shouldn't be working here, we have to use a NSMutableDictionary instead
    
    func dateWasSelected(_ selectedDateString: String) {
        let dateCellSection = 0
        let dateCellRow = 3
        
        ((cellDescriptors[dateCellSection] as! NSMutableArray)[dateCellRow] as AnyObject).setValue(selectedDateString, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func maritalStatusSwitchChangedState(_ isOn: Bool) {
        let maritalSwitchCellSection = 0
        let maritalSwitchCellRow = 6
        
        let valueToStore = (isOn) ? "true" : "false"
        let valueToDisplay = (isOn) ? "Married" : "Single"
        
        ((cellDescriptors[maritalSwitchCellSection] as! NSMutableArray)[maritalSwitchCellRow] as AnyObject).setValue(valueToStore, forKey: "value")
        ((cellDescriptors[maritalSwitchCellSection] as! NSMutableArray)[maritalSwitchCellRow - 1] as AnyObject).setValue(valueToDisplay, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func textfieldTextWasChanged(_ newText: String, parentCell: CustomCell) {
        let parentCellIndexPath = tblExpandable.indexPath(for: parentCell)
        
        let currentFullname = ((cellDescriptors[0] as! NSMutableArray)[0] as AnyObject)["primaryTitle"] as! String
        let fullnameParts = currentFullname.components(separatedBy: " ")
        
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
        
         ((cellDescriptors[0] as! NSMutableArray)[0] as AnyObject).setValue(newFullname, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    
    
    func sliderDidChangeValue(_ newSliderValue: String) {
       ((cellDescriptors[2] as! NSMutableArray)[0] as AnyObject).setValue(newSliderValue, forKey: "primaryTitle")
        ((cellDescriptors[2] as! NSMutableArray)[1] as AnyObject).setValue(newSliderValue, forKey: "value")
        
        tblExpandable.reloadSections(IndexSet(integer: 2), with: UITableViewRowAnimation.none)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinyVC : BasicInputsViewController = segue.destination as! BasicInputsViewController
        DestinyVC.category = category
        DestinyVC.topic = topic
        DestinyVC.option = option
        DestinyVC.menu = TP.lookForAMenu(self.category, self.topic, self.option)
    }


}
