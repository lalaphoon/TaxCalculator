//
//  HomeViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-19.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import PureLayout
//reference: http://www.benmeline.com/search-bar-animation-with-swift/

class MainView: UIView{

 private var searchBar: UISearchBar!
   // searchBar.delegate = self
    
    private var searchButton: UIButton!
    private var resultsTable: UITableView!
    
    private let searchButtonHeight: CGFloat = 40
    private let searchButtonWidth: CGFloat = 300
    
    private let searchBarStartingAlpha: CGFloat = 0
    private let searchButtonStartingAlpha: CGFloat = 1
    private let tableStartingAlpha: CGFloat = 0
    private let searchBarEndingAlpha: CGFloat = 1
    private let searchButtonEndingAlpha: CGFloat = 0
    private let tableEndingAlpha: CGFloat = 1
    
    private let searchButtonStartingCornerRadius: CGFloat = 10
    private let searchButtonEndingCornerRadius: CGFloat = 0
    
    private var searchBarTop = false
    
    private var didSetupConstraints = false
    
    private var searchButtonWidthConstraint: NSLayoutConstraint?
    private var searchButtonEdgeConstraint: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupViews()
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    //initilization
    func setupViews() {
        setupSearchBar()
        setupSearchButton()
        setupResultsTable()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar.newAutoLayoutView()
        searchBar.showsCancelButton = true
        searchBar.alpha = searchBarStartingAlpha
        searchBar.delegate = self
        addSubview(searchBar)
    }
    
    func setupSearchButton() {
        searchButton = UIButton(type: .Custom)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: "searchClicked:", forControlEvents: .TouchUpInside)
        searchButton.setTitle("Search", forState: .Normal)
        searchButton.setImage(UIImage(named:"search_bar.png"), forState: .Normal)
        //searchButton.backgroundColor = UIColor.customOrangeColor()
        searchButton.layer.cornerRadius = searchButtonStartingCornerRadius
        addSubview(searchButton)
    }
    
    func setupResultsTable() {
        resultsTable = UITableView.newAutoLayoutView()
        resultsTable.alpha = tableStartingAlpha
        addSubview(resultsTable)
    }
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            searchBar.autoAlignAxisToSuperviewAxis(.Vertical)
            searchBar.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
            searchBar.autoPinEdgeToSuperviewEdge(.Top)
            
            searchButton.autoSetDimension(.Height, toSize: searchButtonHeight)
            searchButton.autoAlignAxisToSuperviewAxis(.Vertical)
            
            resultsTable.autoAlignAxisToSuperviewAxis(.Vertical)
            resultsTable.autoPinEdgeToSuperviewEdge(.Leading)
            resultsTable.autoPinEdgeToSuperviewEdge(.Trailing)
            resultsTable.autoPinEdgeToSuperviewEdge(.Bottom)
            resultsTable.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
            
            didSetupConstraints = true
        }
        
        searchButtonWidthConstraint?.autoRemove()
        searchButtonEdgeConstraint?.autoRemove()
        
        if searchBarTop {
            searchButtonWidthConstraint = searchButton.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
            searchButtonEdgeConstraint = searchButton.autoPinEdgeToSuperviewEdge(.Top)
        } else {
            searchButtonWidthConstraint = searchButton.autoSetDimension(.Width, toSize: searchButtonWidth)
            searchButtonEdgeConstraint = searchButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - User Interaction
    
    func searchClicked(sender: UIButton!) {
        showSearchBar(searchBar)
    }
    func showSearchBar(searchBar: UISearchBar) {
        searchBarTop = true
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        UIView.animateWithDuration(0.3,
            animations: {
                searchBar.becomeFirstResponder()
                self.layoutIfNeeded()
            }, completion: { finished in
                UIView.animateWithDuration(0.2,
                    animations: {
                        searchBar.alpha = self.searchBarEndingAlpha
                        self.resultsTable.alpha = self.tableEndingAlpha
                        self.searchButton.alpha = self.searchButtonEndingAlpha
                        self.searchButton.layer.cornerRadius = self.searchButtonEndingCornerRadius
                    }
                )
            }
        )
    }
    func dismissSearchBar(searchBar: UISearchBar) {
        searchBarTop = false
        
        UIView.animateWithDuration(0.2,
            animations: {
                searchBar.alpha = self.searchBarStartingAlpha
                self.resultsTable.alpha = self.tableStartingAlpha
                self.searchButton.alpha = self.searchButtonStartingAlpha
                self.searchButton.layer.cornerRadius = self.searchButtonStartingCornerRadius
            }, completion:  { finished in
                self.setNeedsUpdateConstraints()
                self.updateConstraintsIfNeeded()
                UIView.animateWithDuration(0.3,
                    animations: {
                        searchBar.resignFirstResponder()
                        self.layoutIfNeeded()
                    }
                )
            }
        )
    }


}



extension MainView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        dismissSearchBar(searchBar)
    }
}



class HomeViewController: UIViewController {
    
    private var mainView: MainView!
    private var didSetupConstraints = false
    
    //Mark: - View Lifecycle
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        mainView = MainView.newAutoLayoutView()
        view.addSubview(mainView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Layout
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            mainView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            mainView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
            mainView.autoPinEdgeToSuperviewEdge(.Leading)
            mainView.autoPinEdgeToSuperviewEdge(.Trailing)
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    
    
    func initBackground(){
   
    self.view.addBackground("background.jpg")
    self.view.darken(60)
    self.addImage("logo.png",self.view.bounds.width/2-42, 200, 84,20.5)
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
