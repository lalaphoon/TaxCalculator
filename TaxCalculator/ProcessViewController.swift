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
        initPieChart()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pieChart.animate(yAxisDuration: 1, easingOption: ChartEasingOption.EaseOutSine)
    }
    func initPieChart(){
       var chartView = PieChartView(frame: view.frame)
       // view.addSubview(chartView)
        let xValues = ["Income", "Interest income", "Others"]
        
        let yValues = [20.0,30.0, 40.0]
        let chartData:[ChartDataEntry] = [ChartDataEntry(value: yValues[0], xIndex: 0),ChartDataEntry(value: yValues[1], xIndex: 1),ChartDataEntry(value: yValues[2], xIndex: 2)]
        var dataEntries = PieChartDataSet(yVals: chartData, label: "Incomes")
        dataEntries.sliceSpace = 2.0
        dataEntries.colors = ChartColorTemplates.colorful()
        let data = PieChartData(xVals: xValues, dataSet: dataEntries)
        //chartView.data = data
        pieChart.data = data
       
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