//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
enum Location: String {
    case Ontario = "Ontario"
    case British_Columbia = "British Columbia"
    case Alberta = "Alberta"
    case Saskatchewan = "Saskatchewan"
    case Manitoba = "Manitoba"
    case Yukon = "Yukon"
    case Newfoundl_and_AndLabrador = "Newfoundland and Labrador"
    case New_Brunswick = "New Brunswick"
    case Nova_Scotia = "Nova Scotia"
    case Prince_Edward_Island = "Prince Edward Island"
    case Nunavut = "Nunavut"
    case Northwest_Territories = "Northwest Territories"
    case Quebec = "Quebec"
    case Federal = "Federal"
}

var TaxCredit =  [Location : Double]()
TaxCredit = [Location.Federal: 0.15 , Location.Ontario: 0.0505 ]

var test: Double = TaxCredit[Location.Federal]!
1 * test
*/
var ForeignIncome: Double = 8000
var NetIncome : Double = 9000
var nonEligibleFTC : Double = 0 // if  Tax Paid Income 2000/Dividend Income > 15%, TaxPaidIncome2000-(DividendIncome * 15%)
var Deduction_2011 : Double = 800
var ForeignTaxPaid : Double = 1200 //min(Tax Paid Income 2000, Dividend Income 8000 * 15%)
var BasicFederalTax : Double = 568
var BasicPersonalTax : Double = 75


for var i = 0; i < Int(ForeignIncome); i++ {
//var i: Double = 936
    var ratio : Double = (ForeignIncome - nonEligibleFTC - Double(i) - Deduction_2011)/(NetIncome + ForeignIncome - Double(i)-Deduction_2011)
    var FTCLimitation = BasicFederalTax * ratio
    var right : Double = ForeignTaxPaid - min(ForeignTaxPaid, FTCLimitation) - min(ForeignTaxPaid-min(FTCLimitation, ForeignTaxPaid), BasicPersonalTax * ratio)
    var balance : Double = abs(Double(i)  - right)
   if (balance<1){print(i)
    break}

}



