//
//  ContainerView.swift
//  HideStaticCells
//
//  Created by Mengyi LUO on 2016-12-04.
//  Copyright © 2016 lalaphoon. All rights reserved.
//

import Foundation
import UIKit

/*class MainView: UIView {
    private var resultsTable: UITableView!
    private let tableStartingAlpha : CGFloat = 0
    private let tableEndingAlpha : CGFloat = 1
    var cellDescriptors = NSMutableArray()
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupResultsTable()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupResultsTable()
    }
    func setupResultsTable(){
       // resultsTable = UITableView.newAutoLayoutView()
        resultsTable.dataSource = self
        resultsTable.delegate = self
        resultsTable.alpha = tableStartingAlpha
        resultsTable.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        addSubview(resultsTable)
    }
    func congifureTableView(){
        resultsTable.tableFooterView = UIView(frame: CGRectZero)
        resultsTable.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        resultsTable.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        resultsTable.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        resultsTable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        resultsTable.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        resultsTable.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    }
}
extension MainView: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
}*/
