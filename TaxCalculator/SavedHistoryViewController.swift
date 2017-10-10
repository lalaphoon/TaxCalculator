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
    
    var record: Record!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = UIScrollView(frame: UIScreen.main.bounds)
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height:667)
        
        self.containerView = UIView()
        self.scrollView.isUserInteractionEnabled = true
        self.containerView.isUserInteractionEnabled = true
        var xValues : [String]
        var yValues : [Double]
        var tableData : [[String]]
        /*xValues = ["Income", "Interest Income", "Others"]
        yValues = [20.0, 30.0, 40.0]
        tableData = [["Interest Income", "","", "$123.0"],
            ["Province","","","Ontario"],
            ["Total Income","Exclude Interest Income","","$12345"],
            ["Federal Tax","","","$123"],
            ["Provincial Tax","","","$12345"],
            ["Total Tax","","","$123"]
        ]*/
        
        (xValues,yValues,tableData) = initDatas()
        initPieChart(dataPoints: xValues, values:yValues)
        initTable(input: tableData)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         pieChart.animate(yAxisDuration: 1, easingOption: ChartEasingOption.easeOutSine)
    }
    func initDatas()->([String],[Double],[[String]]){
        var output1 = [String]()
        var output2 = [Double]()
        var output3 = [[String]]()
        let v = record.getValues()
        for index in v {
            let key : String = index.key!
            let value: Double = Double(index.value!)
            output1.append(key)
            output2.append(value)
        }
        let td = record.getTableDatas()
        for index in td {
             var i_id = [String]()
            i_id.append(index.first!)
            i_id.append(index.second!)
            i_id.append(index.third!)
            i_id.append(index.forth!)
            output3.append(i_id)
        }
        return (output1, output2,output3)
    }
    func initPieChart(dataPoints:[String], values: [Double]){
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count{
           let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "label for attributes")
        let pieChartData = PieChartData( dataSet: pieChartDataSet)
        
        pieChartDataSet.sliceSpace = 2.0
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        //==============Set up for colors=======================
        var colors: [UIColor] = []
        colors = [UIColor.chartBlueColor(), UIColor.chartYellowColor(), UIColor.chartGreenColor(), UIColor.chartRedColor()]
        pieChartDataSet.colors = colors
        //======================================================
        pieChart.chartDescription?.text = ""
        pieChart.chartDescription?.textAlign = .center
        pieChart.chartDescription?.font = UIFont(name: HEADERFONT, size: 18)!
        pieChart.chartDescription?.xOffset = 100.0
        pieChart.chartDescription?.yOffset = 0.0
        pieChart.data = pieChartData
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x:0, y:0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
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
        let cellCollNib = UINib(nibName: "TableCell", bundle: Bundle.main)
        resultChart.register(cellCollNib, forCellReuseIdentifier: reuseIdentifier)
        resultChart.tableFooterView = UIView()
        resultChart.separatorStyle = .none
        showData = input
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultTableCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ResultTableCell
        let item = showData[indexPath.row]
        cell.Title1.text = item[0]
        cell.Title2.text = item[1]
        cell.Title3.text = item[2]
        cell.Value.text = item[3]
        return cell
    }
}

