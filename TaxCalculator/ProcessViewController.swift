//
//  ProcessViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-27.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ProcessViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var resultChart: UITableView!
    let reuseIdentifier = "TableCell"
    
    var formula : Calculator!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.scrollView =  UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width , 667)
        
        self.containerView =  UIView()
        self.scrollView.userInteractionEnabled = true
        self.containerView.userInteractionEnabled = true
        self.scrollView.addSubview(containerView)
        //self.view.addSubview(scrollView)
       // initProcessUI()
        
        let xValues = ["Income", "Interest income", "Others"]
        
        let yValues = [20.0,30.0, 40.0]
        
        initPieChart(xValues,values: yValues)
        initTable()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pieChart.animate(yAxisDuration: 1, easingOption: ChartEasingOption.EaseOutSine)
    }
    func initPieChart(dataPoints:[String],values: [Double]){
        
       //var chartView = PieChartView(frame: view.frame)
       // view.addSubview(chartView)
        
        var dataEntries:[ChartDataEntry] = []
        
        for i in 0..<dataPoints.count{
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Labels for attributes")
        let pieChartData = PieChartData(xVals:dataPoints, dataSet: pieChartDataSet)
        
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.colors = ChartColorTemplates.colorful()
       // pieChart.centerAttributedText.
       
        //==========================Set up for colors=========================================
        var colors: [UIColor] = []
        
        /*for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }*/
        colors = [UIColor.chartBlueColor(),UIColor.chartYellowColor(),UIColor.chartGreenColor(),UIColor.chartRedColor()]
        
        pieChartDataSet.colors = colors
        //======================================================================================
        
        
        //chartView.data = data
        pieChart.descriptionText = ""
        pieChart.descriptionTextAlign = .Center
        pieChart.descriptionFont = UIFont(name: HEADERFONT, size: 18)
        pieChart.setDescriptionTextPosition(x: 100.0, y: 0.0)
       // pieChart.highlightPerTapEnabled = false
        //This below is used to save a piechart
        //pieChart.saveToCameraRoll()
        pieChart.data = pieChartData
        
       
    }
    func initProcessUI(){
        containerView.addText(formula.displayProcess(),self.view.bounds.width/2, 200, self.view.bounds.width-86, self.view.bounds.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize.height = 3000
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }

    
}

extension ProcessViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTable(){
        resultChart.dataSource = self
        resultChart.delegate = self
        let cellCollNib = UINib (nibName: "TableCell", bundle: NSBundle.mainBundle())
        resultChart.registerNib(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
        resultChart.tableFooterView =  UIView()
        //resultChart.tableHeaderView = UIView()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ResultTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ResultTableCell
        cell.Title1.text = "changed"
        cell.Title2.text = "changed"
        cell.Title3.text = "changed"
        cell.Value.text = "0"
        return cell
    }
}
class ResultTableCell : UITableViewCell {

    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    @IBOutlet weak var Title3: UILabel!
    @IBOutlet weak var Value: UILabel!
    override func awakeFromNib(){
        super.awakeFromNib()
      
        Title1.font = UIFont(name: BIGTITLE, size: 17.0)
        Title1.textColor = UIColor.blackColor()
        Title2.font = UIFont(name: SMALLTITLE, size: 13.0)
        Title2.textColor = UIColor.grayColor()
        Title3.font = UIFont(name: SMALLTITLE, size: 13.0)
        Title3.textColor = UIColor.grayColor()
        Value.font = UIFont(name: BIGTITLE, size: 17.0)
        Value.textColor = UIColor.blackColor()
      
    }
    /*override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }*/
}


