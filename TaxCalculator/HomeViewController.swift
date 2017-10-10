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
    
    fileprivate var searchButton: UIButton!
    fileprivate var resultsTable: UITableView!
    
    fileprivate let searchButtonHeight: CGFloat = 40
    fileprivate let searchButtonWidth: CGFloat = 310
    
    fileprivate let searchBarStartingAlpha: CGFloat = 0
    fileprivate let searchButtonStartingAlpha: CGFloat = 1
    fileprivate let tableStartingAlpha: CGFloat = 0
    fileprivate let searchBarEndingAlpha: CGFloat = 1
    fileprivate let searchButtonEndingAlpha: CGFloat = 0
    fileprivate let tableEndingAlpha: CGFloat = 1
    
    fileprivate let searchButtonStartingCornerRadius: CGFloat = 10
    fileprivate let searchButtonEndingCornerRadius: CGFloat = 0
    
    fileprivate var searchBarTop = false
    var searchActive : Bool = false
    fileprivate var didSetupConstraints = false
    
    fileprivate var searchButtonWidthConstraint: NSLayoutConstraint?
    fileprivate var searchButtonEdgeConstraint: NSLayoutConstraint?
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainView.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
       searchBar.endEditing(true)
    }
    func filterList(){
        copyTaxMenuBook.sort(by: {$0.name < $1.name})
    
    }
    func setupSearchBar() {
        searchBar = UISearchBar.newAutoLayout()
        searchBar.showsCancelButton = true
        searchBar.alpha = searchBarStartingAlpha
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["All", "Income", "Deduction", "Tax Credit"]
        searchBar.showsScopeBar = true
       // searchBar.backgroundColor = UIColor.customOrangeColor()
        searchBar.barTintColor = UIColor.customOrangeColor()
        searchBar.tintColor = UIColor.white
        addSubview(searchBar)
    }
    
    func setupSearchButton() {
        searchButton = UIButton(type: .custom)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(MainView.searchClicked(_:)), for: .touchUpInside)
        searchButton.setTitle("Search", for: UIControlState())
        searchButton.setImage(UIImage(named:"search_bar.png"), for: UIControlState())
        //searchButton.backgroundColor = UIColor.customOrangeColor()
        searchButton.layer.cornerRadius = searchButtonStartingCornerRadius
        addSubview(searchButton)
    }
    
    func setupResultsTable() {
        resultsTable = UITableView.newAutoLayout()
        resultsTable.dataSource = self
        resultsTable.delegate = self
        resultsTable.alpha = tableStartingAlpha
        resultsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(resultsTable)
    }
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            searchBar.autoAlignAxis(toSuperviewAxis: .vertical)
            searchBar.autoMatch(.width, to: .width, of: self)
            searchBar.autoPinEdge(toSuperviewEdge: .top)
            
            searchButton.autoSetDimension(.height, toSize: searchButtonHeight)
            searchButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            resultsTable.autoAlignAxis(toSuperviewAxis: .vertical)
            resultsTable.autoPinEdge(toSuperviewEdge: .leading)
            resultsTable.autoPinEdge(toSuperviewEdge: .trailing)
            resultsTable.autoPinEdge(toSuperviewEdge: .bottom)
            resultsTable.autoPinEdge(.top, to: .bottom, of: searchBar)
            
            didSetupConstraints = true
        }
        
        searchButtonWidthConstraint?.autoRemove()
        searchButtonEdgeConstraint?.autoRemove()
        
        if searchBarTop {
            searchButtonWidthConstraint = searchButton.autoMatch(.width, to: .width, of: self)
            searchButtonEdgeConstraint = searchButton.autoPinEdge(toSuperviewEdge: .top)
        } else {
            searchButtonWidthConstraint = searchButton.autoSetDimension(.width, toSize: searchButtonWidth)
            searchButtonEdgeConstraint = searchButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - User Interaction
    
    func searchClicked(_ sender: UIButton!) {
        showSearchBar(searchBar)
    }
    func showSearchBar(_ searchBar: UISearchBar) {
        searchBarTop = true
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        UIView.animate(withDuration: 0.3,
            animations: {
                searchBar.becomeFirstResponder()
                self.layoutIfNeeded()
            }, completion: { finished in
                UIView.animate(withDuration: 0.2,
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
    func dismissSearchBar(_ searchBar: UISearchBar) {
        searchBarTop = false
        
        UIView.animate(withDuration: 0.2,
            animations: {
                searchBar.alpha = self.searchBarStartingAlpha
                self.resultsTable.alpha = self.tableStartingAlpha
                self.searchButton.alpha = self.searchButtonStartingAlpha
                self.searchButton.layer.cornerRadius = self.searchButtonStartingCornerRadius
            }, completion:  { finished in
                self.setNeedsUpdateConstraints()
                self.updateConstraintsIfNeeded()
                UIView.animate(withDuration: 0.3,
                    animations: {
                        searchBar.resignFirstResponder()
                        self.layoutIfNeeded()
                    }
                )
            }
        )
    }
    func filterContentForSearchText(_ searchText: String, scope: Int = 0){
       print("scope is\(scope)")
        filteredMenus = copyTaxMenuBook.filter({(menu: Menu) -> Bool in
            let menuMatch = (scope == 0) || (menu.category == scope)
            
            return menuMatch && menu.name.lowercased().contains(searchText.lowercased())
        })
       resultsTable.reloadData()
    }
}


//http://shrikar.com/swift-ios-tutorial-uisearchbar-and-uisearchbardelegate/
extension MainView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchActive = false
        dismissSearchBar(searchBar)
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        var i : Int
        if searchBar.scopeButtonTitles![selectedScope] == "All" {
            i = 0
        } else {
            i = TaxMenu[searchBar.scopeButtonTitles![selectedScope]]!
        }
        filterContentForSearchText(searchBar.text!, scope: i)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text!)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        dismissKeyboard()
    }
    
   
}


extension MainView: UITableViewDataSource, UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" && searchActive {
            if filteredMenus.count == 0{
                resultsTable.separatorStyle = .none
                resultsTable.backgroundView?.isHidden = false
            } else {
                resultsTable.separatorStyle = .singleLine
                resultsTable.backgroundView?.isHidden = true
            }
            
            return filteredMenus.count
        }
        return copyTaxMenuBook.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("YOuselected cell \(indexPath.row)")
        let menu:Menu
        if searchBar.text != "" && searchActive {
            menu = filteredMenus[indexPath.row]
        } else {
            menu = copyTaxMenuBook[indexPath.row]
        }
        self.formula = menu
        tableView.deselectRow(at: indexPath, animated: true)
        // HomeView.performSegueWithIdentifier("MoveIntoCalculation", sender: HomeView)
        delegate?.gotoNextView()
        //HomeViewController.gotoNextView()
    }
   
}



class HomeViewController: UIViewController, MainViewDelegate,MFMailComposeViewControllerDelegate  {
    
    //@IBOutlet weak var mainMenu: UIBarButtonItem!
    fileprivate var mainView: MainView!
    fileprivate var didSetupConstraints = false
    
    fileprivate let image = UIImage(named: "box")!.withRenderingMode(.alwaysTemplate)
    fileprivate let topMessage = "Oops!"
    fileprivate let bottomMessage = "There are no matches for your search. Contact one of our tax specialist to answer your question!"
    //Mark: - View Lifecycle
    
    let messageTitle: String = "TaxPro-Topics' Questions."
    let messageBody: String = "\n\n\n System Version：\(SYSTEMVERSION )\n Device Model：\(modelName)"
    
    var TP = TaxPro()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        mainView = MainView.newAutoLayout()
        mainView.delegate = self
        //self.hideKeyboardWhenTappedAround()
        //mainView.hideKeyboard()
        setupEmptyBackgroundView()
        view.addSubview(mainView)
        
        //print(TP.flag_a_group(0, TP.ProvincialBracketDictionary[Location.Ontario]!))
        //print(TP.flag_a_group(12, TP.ProvincialBracketDictionary[Location.Ontario]!))
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
            self.present(mailComposeViewController, animated: true, completion: nil)
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
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle:  UIAlertControllerStyle.alert)
    }
    func sendAlert(_ alertTitle : String, alertMessage : String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled mail")
            sendAlert("Sending Cancelled", alertMessage: "You have cancelled sending your email!")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
            sendAlert("Mail Sent", alertMessage: "Your email has been sent to us!\n Thank you very much!")
        case MFMailComposeResult.saved.rawValue:
            print("You saved a draft of this email")
            break;
        default:
            break
        }
        
    }

    
    
    
    
    
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            mainView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
            mainView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
            mainView.autoPinEdge(toSuperviewEdge: .leading)
            mainView.autoPinEdge(toSuperviewEdge: .trailing)
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let cell = sender as! UITableViewCell
        //cell.textLabel?.text
        if (segue.identifier == "MoveIntoCalculation"){
            if mainView.formula != nil {
                let DestinyVC: BasicInputsViewController = segue.destination as! BasicInputsViewController
                DestinyVC.menu = mainView.formula
               // DestinyVC.category = 1
               // DestinyVC.topic = 1
               // DestinyVC.option = 1
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
     performSegue(withIdentifier: "MoveIntoCalculation", sender: self)
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


