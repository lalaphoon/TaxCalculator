//
//  HomeViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-19.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit
import PureLayout
import MessageUI

//reference: http://www.benmeline.com/search-bar-animation-with-swift/

protocol MainViewDelegate: class {
    func gotoNextView()
}

class MainView: UIView{

  var searchBar: UISearchBar!
   // searchBar.delegate = self
    
    private var searchButton: UIButton!
    private var resultsTable: UITableView!
    
    private let searchButtonHeight: CGFloat = 40
    private let searchButtonWidth: CGFloat = 310
    
    private let searchBarStartingAlpha: CGFloat = 0
    private let searchButtonStartingAlpha: CGFloat = 1
    private let tableStartingAlpha: CGFloat = 0
    private let searchBarEndingAlpha: CGFloat = 1
    private let searchButtonEndingAlpha: CGFloat = 0
    private let tableEndingAlpha: CGFloat = 1
    
    private let searchButtonStartingCornerRadius: CGFloat = 10
    private let searchButtonEndingCornerRadius: CGFloat = 0
    
    private var searchBarTop = false
    var searchActive : Bool = false
    private var didSetupConstraints = false
    
    private var searchButtonWidthConstraint: NSLayoutConstraint?
    private var searchButtonEdgeConstraint: NSLayoutConstraint?
    
    var copyTaxMenuBook : [Menu] = taxMenuBook
    var filteredMenus = [Menu]()
    var formula : Menu!
    // var HomeView: HomeViewController!
    weak var delegate: MainViewDelegate?
    
    
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
        filterList()
        
    }
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
       searchBar.endEditing(true)
    }
    func filterList(){
        copyTaxMenuBook.sortInPlace({$0.name < $1.name})
    
    }
    func setupSearchBar() {
        searchBar = UISearchBar.newAutoLayoutView()
        searchBar.showsCancelButton = true
        searchBar.alpha = searchBarStartingAlpha
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["All", "Income", "Deduction", "Tax Credit"]
        searchBar.showsScopeBar = true
       // searchBar.backgroundColor = UIColor.customOrangeColor()
        searchBar.barTintColor = UIColor.customOrangeColor()
        searchBar.tintColor = UIColor.whiteColor()
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
        resultsTable.dataSource = self
        resultsTable.delegate = self
        resultsTable.alpha = tableStartingAlpha
        resultsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    func filterContentForSearchText(searchText: String, scope: Int = 0){
       print("scope is\(scope)")
        filteredMenus = copyTaxMenuBook.filter({(menu: Menu) -> Bool in
            let menuMatch = (scope == 0) || (menu.category == scope)
            
            return menuMatch && menu.name.lowercaseString.containsString(searchText.lowercaseString)
        })
       resultsTable.reloadData()
    }
}


//http://shrikar.com/swift-ios-tutorial-uisearchbar-and-uisearchbardelegate/
extension MainView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchActive = false
        dismissSearchBar(searchBar)
        
    }
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        var i : Int
        if searchBar.scopeButtonTitles![selectedScope] == "All" {
            i = 0
        } else {
            i = TaxMenu[searchBar.scopeButtonTitles![selectedScope]]!
        }
        filterContentForSearchText(searchBar.text!, scope: i)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text!)
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
    }
    
   
}


extension MainView: UITableViewDataSource, UITableViewDelegate{
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" && searchActive {
            if filteredMenus.count == 0{
                resultsTable.separatorStyle = .None
                resultsTable.backgroundView?.hidden = false
            } else {
                resultsTable.separatorStyle = .SingleLine
                resultsTable.backgroundView?.hidden = true
            }
            
            return filteredMenus.count
        }
        return copyTaxMenuBook.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let menu:Menu
        if searchBar.text != "" && searchActive {
            menu = filteredMenus[indexPath.row]
        } else {
            menu = copyTaxMenuBook[indexPath.row]
        }
        cell.textLabel?.text = menu.name
        cell.textLabel?.font = UIFont(name: BIGTITLE, size: 16)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("YOuselected cell \(indexPath.row)")
        let menu:Menu
        if searchBar.text != "" && searchActive {
            menu = filteredMenus[indexPath.row]
        } else {
            menu = copyTaxMenuBook[indexPath.row]
        }
        self.formula = menu
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // HomeView.performSegueWithIdentifier("MoveIntoCalculation", sender: HomeView)
        delegate?.gotoNextView()
        //HomeViewController.gotoNextView()
    }
   
}



class HomeViewController: UIViewController, MainViewDelegate,MFMailComposeViewControllerDelegate  {
    
    //@IBOutlet weak var mainMenu: UIBarButtonItem!
    private var mainView: MainView!
    private var didSetupConstraints = false
    
    private let image = UIImage(named: "box")!.imageWithRenderingMode(.AlwaysTemplate)
    private let topMessage = "Oops!"
    private let bottomMessage = "There are no matches for your search. Contact one of our tax specialist to answer your question!"
    //Mark: - View Lifecycle
    
    let messageTitle: String = "TaxPro-Topics' Questions."
    let messageBody: String = "\n\n\n System Version：\(SYSTEMVERSION )\n Device Model：\(modelName)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        mainView = MainView.newAutoLayoutView()
        mainView.delegate = self
        //self.hideKeyboardWhenTappedAround()
        //mainView.hideKeyboard()
        setupEmptyBackgroundView()
        view.addSubview(mainView)
        
        //This is used to hide submenu
        /*if self.revealViewController() != nil {
            mainMenu.target = self.revealViewController()
            mainMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Layout
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        emptyBackgroundView.addLinkButton("Contact Us", "sendEmail", self.view.bounds.width/2-50, self.view.bounds.height/2, 100, 20, self)
        mainView.resultsTable.backgroundView = emptyBackgroundView
    }
    func sendEmail(){
        print("Sending email on Home view")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate =  self
        mailComposerVC.setToRecipients(["lalaphoon@gmail.com", "will@wtctax.ca"])
        mailComposerVC.setSubject(self.messageTitle)
        mailComposerVC.setMessageBody(self.messageBody, isHTML: false)
        return mailComposerVC
    }
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle:  UIAlertControllerStyle.Alert)
    }
    func sendAlert(alertTitle : String, alertMessage : String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled mail")
            sendAlert("Sending Cancelled", alertMessage: "You have cancelled sending your email!")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
            sendAlert("Mail Sent", alertMessage: "Your email has been sent to us!\n Thank you very much!")
        case MFMailComposeResultSaved.rawValue:
            print("You saved a draft of this email")
            break;
        default:
            break
        }
        
    }

    
    
    
    
    
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let cell = sender as! UITableViewCell
        //cell.textLabel?.text
        if (segue.identifier == "MoveIntoCalculation"){
            if mainView.formula != nil {
                var DestinyVC: BasicInputsViewController = segue.destinationViewController as! BasicInputsViewController
                DestinyVC.menu = mainView.formula
                DestinyVC.category = 1
                DestinyVC.topic = 1
                DestinyVC.option = 1
            }
        }
    }
    
    func initBackground(){
   self.navigationItem.title = "Home"
    self.view.addBackground("background.jpg")
    //self.view.darken(60)
    self.view.whiten(40)
   // self.addLabel("Never be blinded sided by personal tax again")
    //self.addImage("logo.png",self.view.bounds.width/2-42, 230, 84,20.5)
    self.addImage("logo.png",self.view.bounds.width/2-153, self.view.bounds.height/2-40, 84, 20.5)
    }
    
    
    func gotoNextView(){
     mainView.searchBarCancelButtonClicked(mainView.searchBar)
     mainView.dismissKeyboard()
     performSegueWithIdentifier("MoveIntoCalculation", sender: self)
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


