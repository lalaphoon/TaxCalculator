//
//  SavedHistoryViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-29.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import Charts

class SavedHistoryViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var containerView: UIView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var resultChart: UITableView!
    var showData = [[String]]()
    let reuseIdentifier = "HistoryTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.width, 667)
        
        self.containerView = UIView()
        self.scrollView.userInteractionEnabled = true
        self.containerView.userInteractionEnabled = true
        
        let xValues = ["Income", "Interest Income", "Others"]
        let yValues = [20.0, 30.0, 40.0]
        let tableData = [["Interest Income", "","", "$123.0"],
            ["Province","","","Ontario"],
            ["Total Income","Exclude Interest Income","","$12345"],
            ["Federal Tax","","","$123"],
            ["Provincial Tax","","","$12345"],
            ["Total Tax","","","$123"]
        ]
        initPieChart(xValues, values:yValues)
        initTable(tableData)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(animated)
         pieChart.animate(yAxisDuration: 1, easingOption: ChartEasingOption.EaseOutSine)
    }
    func initPieChart(dataPoints:[String], values: [Double]){
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count{
           let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Labels for attributes")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        //==============Set up for colors=======================
        var colors: [UIColor] = []
        colors = [UIColor.chartBlueColor(), UIColor.chartYellowColor(), UIColor.chartGreenColor(), UIColor.chartRedColor()]
        pieChartDataSet.colors = colors
        //======================================================
        pieChart.descriptionText = ""
        pieChart.descriptionTextAlign = .Center
        pieChart.descriptionFont = UIFont(name: HEADERFONT, size: 18)
        pieChart.setDescriptionTextPosition(x: 100.0, y: 0.0)
        pieChart.data = pieChartData
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
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
extension SavedHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func initTable(input: [[String]]){
        resultChart.dataSource = self
        resultChart.delegate = self
        let cellCollNib = UINib(nibName: "TableCell", bundle: NSBundle.mainBundle())
        resultChart.registerNib(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
        resultChart.tableFooterView = UIView()
        resultChart.separatorStyle = .None
        showData = input
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ResultTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ResultTableCell
        let item = showData[indexPath.row]
        cell.Title1.text = item[0]
        cell.Title2.text = item[1]
        cell.Title3.text = item[2]
        cell.Value.text = item[3]
        return cell
    }
}

