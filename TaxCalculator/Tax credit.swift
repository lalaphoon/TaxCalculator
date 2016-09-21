//
//  Tax credit.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-03.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
class Adoption_Tax_Credit: Formula{
    static let sharedInstance = Adoption_Tax_Credit()
    var TP = TaxPro()
    let maximum = 15255
    var Adoption_Expense = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    
    private init(){
    
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        Adoption_Expense = containerView.returnTextField("Adoption expense", 43, 274 + num, VC.view.bounds.width - (43*2))
        Adoption_Expense.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567 + num, 87, 36, VC)
        return containerView
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var input = Double(self.Adoption_Expense.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        return TP.TaxCredit["Federal"]! * input! + TP.TaxCredit[profileProvince]! * input!
    }
    func getInstruction() -> String {
        return "What do we need to say here?"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var input = Double(self.Adoption_Expense.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        var output1 = ["Adoption expense", "Tax Credit"]
        var output2 = [Double(Adoption_Expense.text!),getResult() ]
        var output3 = [ ["Adoption expense","","","\(Adoption_Expense.text!)"],
                        ["Province","","",profileProvince],
                        ["Federal tax credit","\(TP.TaxCredit["Federal"])","","\(TP.TaxCredit["Federal"]! * input!)"],
                        ["\(profileProvince) tax credit","\(TP.TaxCredit[profileProvince])","","\(TP.TaxCredit[profileProvince]! * input!)"]]
        return (output1, output2 as! [Double], output3)
    }
    func getTip() -> String {
        return "Maximum adoption expenses eligible for tax credit is $15,255. Eligible adoption expenses include: fees paid to an adoption agency licensed by the government, legal expenses relating to adoption order, other reasonable expenses. Child must be under 18 years of age at the time the adoption order is issued by Government of Canada. "
    }
    func displayProcess() -> String {
        var input = Double(self.Adoption_Expense.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        var process = String()
        process = "--------------------\n"
        process = process + "Province:    \(profileProvince)\n"
        process = process + "Adoption expense :  \(Adoption_Expense)\n"
        process = "---------------------\n"
        process = process + "Federal   \(TP.TaxCredit["Federal"])   \(TP.TaxCredit["Federal"]! * input!)\n"
        process = process + "\(profileProvince)   \(TP.TaxCredit[profileProvince])    \(TP.TaxCredit[profileProvince]! * input!)\n"
        process = process + "Result :  \(getResult())"
        return process
    }
    
}

class Pension_Tax_Credit: Formula{
    static let sharedInstance = Pension_Tax_Credit()
    var TP = TaxPro()
    let maximum = 2000
    var Pension_income = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    
    private init(){
        
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        Pension_income = containerView.returnTextField("Pension income", 43, 274 + num, VC.view.bounds.width - (43*2))
        Pension_income.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567 + num, 87, 36, VC)
        return containerView
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var input = Double(self.Pension_income.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        return TP.TaxCredit["Federal"]! * input! + TP.TaxCredit[profileProvince]! * input!
    }
    func getInstruction() -> String {
        return "What do we need to say here?"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var input = Double(self.Pension_income.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        var output1 = ["Pension income", "Tax Credit"]
        var output2 = [Double(Pension_income.text!),getResult() ]
        var output3 = [ ["Pension income","","","\(Pension_income.text!)"],
            ["Province","","",profileProvince],
            ["Federal tax credit","\(TP.TaxCredit["Federal"])","","\(TP.TaxCredit["Federal"]! * input!)"],
            ["\(profileProvince) tax credit","\(TP.TaxCredit[profileProvince])","","\(TP.TaxCredit[profileProvince]! * input!)"]]
        return (output1, output2 as! [Double], output3)
    }
    func getTip() -> String {
        return "Maximum pension income eligible for tax credit is $2,000. Pension income eligible for pension tax credit will depend on your age. For individuals 65 and over, all pension income are eligible. For individuals under 65, 'eligible pension income' includes life annuity from a pension plan and pension income received due to death of spouse or common-law partner."
    }
    func displayProcess() -> String {
        var input = Double(self.Pension_income.text!)
        if input > Double(maximum) {
            input = Double( maximum)
        }
        var process = String()
        process = "--------------------\n"
        process = process + "Province:    \(profileProvince)\n"
        process = process + "Pension income :  \(Pension_income)\n"
        process = "---------------------\n"
        process = process + "Federal   \(TP.TaxCredit["Federal"])   \(TP.TaxCredit["Federal"]! * input!)\n"
        process = process + "\(profileProvince)   \(TP.TaxCredit[profileProvince])    \(TP.TaxCredit[profileProvince]! * input!)\n"
        process = process + "Result :  \(getResult())"
        return process
    }
    
}

class Interest_Paid_on_Student_Loan: Formula{
    static let sharedInstance = Interest_Paid_on_Student_Loan()
    var TP = TaxPro()
   
    var Interest_expense = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    
    private init(){
        
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        Interest_expense = containerView.returnTextField("Interest Expense", 43, 274 + num, VC.view.bounds.width - (43*2))
        Interest_expense.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567 + num, 87, 36, VC)
        return containerView
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var input = Double(self.Interest_expense.text!)
       
        return TP.TaxCredit["Federal"]! * input! + TP.TaxCredit[profileProvince]! * input!
    }
    func getInstruction() -> String {
        return "What do we need to say here?"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var input = Double(self.Interest_expense.text!)
        
        var output1 = ["Interest expense", "Tax Credit"]
        var output2 = [Double(Interest_expense.text!),getResult() ]
        var output3 = [ ["Adoption expense","","","\(Interest_expense.text!)"],
            ["Province","","",profileProvince],
            ["Federal tax credit","\(TP.TaxCredit["Federal"])","","\(TP.TaxCredit["Federal"]! * input!)"],
            ["\(profileProvince) tax credit","\(TP.TaxCredit[profileProvince])","","\(TP.TaxCredit[profileProvince]! * input!)"]]
        return (output1, output2 as! [Double], output3)
    }
    func getTip() -> String {
        return "Repayment on principal portion of the loan is not tax deductible, only the interest is eligible for tax credit. Student can only claim interest on student loans under the Canada Student Loans Program or a provinancial student loans program. Unused credits may be carried forward for up to 5 years."
    }
    func displayProcess() -> String {
        var input = Double(self.Interest_expense.text!)
       
        var process = String()
        process = "--------------------\n"
        process = process + "Province:    \(profileProvince)\n"
        process = process + "Interest Expense :  \(Interest_expense)\n"
        process = "---------------------\n"
        process = process + "Federal   \(TP.TaxCredit["Federal"])   \(TP.TaxCredit["Federal"]! * input!)\n"
        process = process + "\(profileProvince)   \(TP.TaxCredit[profileProvince])    \(TP.TaxCredit[profileProvince]! * input!)\n"
        process = process + "Result :  \(getResult())"
        return process
    }
    
}

class Tuition_Education_TextbookCredits : Formula {
    static let sharedInstance = Tuition_Education_TextbookCredits()
    var TP = TaxPro()
    
    var TuitionFees = UITextField()
    var numFullTimeStudent = UITextField()
    var numPartTimeStudent = UITextField()
    
    var profileIncome : Double!
    var profileProvince: String!
    
    
    private init(){
        
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        TuitionFees = containerView.returnTextField("Tuition Fees", 43, 274 + num, VC.view.bounds.width - (43*2))
        TuitionFees.keyboardType = .DecimalPad
        numFullTimeStudent = containerView.returnTextField("Number of months as full time students", 43, 334 + num, VC.view.bounds.width - (43*2))
        numFullTimeStudent.keyboardType = .DecimalPad
        numPartTimeStudent = containerView.returnTextField("Number of months as part time students", 43, 394 + num, VC.view.bounds.width - (43*2))
        numPartTimeStudent.keyboardType = .DecimalPad
        
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567 + num, 87, 36, VC)
        return containerView
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var input = Double(self.TuitionFees.text!)
        //Education credit
        var A = Double(400) * Double(numFullTimeStudent.text!)!
        var B = Double(120) * Double(numPartTimeStudent.text!)!
        input = input! + A + B
        //Textbook credit
         A = Double(65) * Double(numFullTimeStudent.text!)!
         B = Double(20) * Double(numPartTimeStudent.text!)!
        input = input! + A + B
        return TP.TaxCredit["Federal"]! * input! + TP.TaxCredit[profileProvince]! * input!
    }
    func getInstruction() -> String {
        return "What do we need to say here?"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        var output1 = ["Tuition fees", "non-refundable tax credit"]
        var output2 = [Double(self.TuitionFees.text!), getResult()]
        var A = Double(400) * Double(numFullTimeStudent.text!)!
        var B = Double(120) * Double(numPartTimeStudent.text!)!
        
        var C = Double(65) * Double(numFullTimeStudent.text!)!
        var D = Double(20) * Double(numPartTimeStudent.text!)!
        var sum = A+B+C+D
        var output3 = [["Tuition fees","","",TuitionFees.text!],
                       ["Number of months","as full-time student","",numFullTimeStudent.text!],
                       ["Number of months","as part-time student","",numPartTimeStudent.text!],
                       ["Education credit","400","","\(A)"],
                       ["","120","","\(B)"],
                       ["Textbook credit","65","","\(C)"],
                       ["","20","","\(D)"],
                       ["sum","","","\(sum)"],
                       ["Federal tax credit","\(TP.TaxCredit["Federal"])","","\(TP.TaxCredit["Federal"]! * sum)"],
                       ["Province tax credit","\(TP.TaxCredit[profileProvince])","","\(TP.TaxCredit[profileProvince]! * sum)"],
                        ["Non-refundable tax credit","","","\(getResult())"]]
        return (output1, output2 as! [Double],output3)
    }
    func getTip() -> String {
        return "Students are required to claim their tuition tax credit first on their own return to reduce their taxes to zero. Students may then transfer any unused tuition credit to their spouse, common-law partner, parents, or grandparents. Maximum amount that can be transferred is $5,000. Any unused tuition credit that are not used and are not transferred can be carried forward to a future year."
    }
    func displayProcess() -> String {
        var input = Double(self.TuitionFees.text!)
        
        var process = String()
        process = "--------------------\n"
        process = process + "Province:    \(profileProvince)\n"
        process = process + "Tuition fees :  \(TuitionFees)\n"
        process = process + "# of months as full-time student:  \(numFullTimeStudent)\n"
        process = process + "# of months as part-time student:  \(numPartTimeStudent)\n"
        process = "---------------------\n"
        var A = Double(400) * Double(numFullTimeStudent.text!)!
        var B = Double(120) * Double(numPartTimeStudent.text!)!
        process = process + "Education credit       400        \(A)\n"
        process = process + "                       120         \(B)\n"
        input = input! + A + B
        A = Double(65) * Double(numFullTimeStudent.text!)!
        B = Double(20) * Double(numPartTimeStudent.text!)!
        process = process + "Textbook credit        65          \(A)\n"
        process = process + "                       20          \(B)\n"
        input = input! + A + B
        process = process + "Federal   \(TP.TaxCredit["Federal"])   \(TP.TaxCredit["Federal"]! * input!)\n"
        process = process + "\(profileProvince)   \(TP.TaxCredit[profileProvince])    \(TP.TaxCredit[profileProvince]! * input!)\n"
        process = process + "Result :  \(getResult())"
        return process
    }

}

/*class Medical_Expense : Formula {
    static let sharedInstance = Medical_Expense()
    var TP = TaxPro()
    
    var MedicalExpense = UITextField()
    let FederalThreshold = 2208
    let OntarioThreshold = 2232
    
    var profileIncome : Double!
    var profileProvince: String!
    private init(){
        
    }
    func initUI(VC: UIViewController) -> UIView {
        var containerView = UIView()
        let num: CGFloat = -63
        containerView.addImage("Title_calculation.png", VC.view.bounds.width/2 - 65, 93 + num)
        MedicalExpense = containerView.returnTextField("Medical expense", 43, 274 + num, VC.view.bounds.width - (43*2))
        MedicalExpense.keyboardType = .DecimalPad
        containerView.addYellowButton("Next", "moveToNext", VC.view.bounds.width - 100, 567 + num, 87, 36, VC)
        return containerView
    }
    func setProfile(income: Double, province: String) {
        profileIncome = income
        profileProvince = province
    }
    func getResult() -> Double {
        var medicalexpense = Double(self.MedicalExpense.text!)
        
        //Federal amount
        var stepone = 0.03 * profileIncome
        var steptwo = min(stepone, Double(FederalThreshold))
        var stepthree : Double = 0
        if medicalexpense > steptwo {
          stepthree = medicalexpense! - steptwo
        }
        //Ontario amount
        var stepfour = min(stepone, Double(OntarioThreshold))
        var stepfive : Double = 0
        if medicalexpense > steptwo {
            stepfive = medicalexpense! - stepfour
        }
        return TP.TaxCredit["Federal"]! * stepthree + TP.TaxCredit[profileProvince]! * stepfive
    }
    func getInstruction() -> String {
        return "What do we need to say here?"
    }
    func retrieveData() -> ([String],[Double],[[String]]) {
        
    }
    func getTip() -> String {
        return "An individual can optimize medical tax credit by claiming medical expense paid in any consecutive 12-month period that ends in 2016 and that have not been claimed in 2015 (eg. From April 1, 2015 to March 31, 2016 instead of the calendar year). Individual can claim medical expense for self, spouse/common-law partner, children under 18, and other dependants who are Canadian residents. Low income families are also eligible for refundable medical expense supplement."
    }
    func displayProcess() -> String {
        var medicalexpense = Double(self.MedicalExpense.text!)
        var process = String()
        process = "-----------------------------\n"
        //Federal amount
        process = process + "Federal amount\n"
        var stepone = 0.03 * profileIncome
        process = process + "Net income parameter       3%      \(stepone)\n "
        process = process + "Threshold          \(FederalThreshold)\n"
        var steptwo = min(stepone, Double(FederalThreshold))
        process = process + "Choose the minimum     \(steptwo)\n"
        var stepthree : Double = 0
        if medicalexpense > steptwo {
            stepthree = medicalexpense! - steptwo
        }
        process = process + "Eligible medical expense    \(stepthree)\n"
        //Ontario amount
        process = process + "Ontario amount\n"
        process = process + "Net income parameter       3%      \(stepone)\n "
        var stepfour = min(stepone, Double(OntarioThreshold))
        process = process + "Choose the minimum     \(stepfour)\n"
        var stepfive : Double = 0
        if medicalexpense > steptwo {
            stepfive = medicalexpense! - stepfour
        }
        process = process + "Eligible medical expense    \(stepfive)\n"
        process = process + "Federal   \(TP.TaxCredit["Federal"])   \(TP.TaxCredit["Federal"]! * stepthree)\n"
        process = process + "\(profileProvince)   \(TP.TaxCredit[profileProvince])    \(TP.TaxCredit[profileProvince]! * stepfive)\n"
        process = process + "Result :  \(getResult())"
        return process
    }
    
}
*/







































