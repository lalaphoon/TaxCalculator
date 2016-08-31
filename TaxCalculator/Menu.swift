//
//  Menu.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-08-29.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import UIKit

//WARNING: YOU MIGHT NEED TO CHANGE THE TOPICS/SUBTOPICS/OPTIONS PAGES IF YOU CHANGE THE MENU.

//let TaxBook = [INCOME:[EMPLOYMENT:Employment,]]



let TaxMenu = [ "Income":1,
                "Deduction":2,
                "Credit":3]
let INCOME = 1
let DEDUCTION = 2
let TAXCREDIT = 3
//======================Income========================================
let Income_subMenu = ["Employment": 1,
                      "Dividend Income": 2,
                      "Interest Income": 3,
                      "Investment Income": 4,
                      "Capital Gain": 5,
                      "Rental Income": 6,
                      "Business and Professional Income": 7,
                      "Pension and Other Income": 8]
let EMPLOYMENT = 1
let DIVIDENDINCOME = 2
let INTERESTINCOME = 3
let CAPITALGAIN = 4
let RENTALINCOME = 5
let BUSINESSANDPROFESSIONALINCOME = 6
let INVESTMENTINCOME = 7
let PENSIONOTHERINCOME = 8

let Employment = ["Employment Income": 1,
                    "Employer-Provided Automobile and Vehicle Benefits": 2,
                    "Allowances": 3,
                    "Expense Reimbursement": 4,
                    "Stock Option" : 5]
let Dividend_Income = ["Dividend income from Securities (Stock, Mutual Funds, etc)": 1,
                        "Dividend income from Business": 2,
                        "Dividend income (non-eligible only)": 3,
                        "Dividend income from TFSA": 4,
                        "Dividend income from RRSP": 5,
                        "Other Types of Dividend Income": 6,
                        "Capital Gains Dividends": 7]
let Interest_Income = ["Interest income from bank deposits": 1,
                        "Interest income from money loaned": 2,
                        "Interest income from bonds": 3,
                        "Interest income from GIC": 4,
                        "Interest income from Treasury Bills": 5,
                        "Interest income from TFSA": 6,
                        "Interest income from RRSP": 7,
                        "Other types of interest income": 8]
let Capital_Gain = ["Sale of publicly traded shares (eg. Stock market trading)": 1,
                    "Sale of mutual fund units": 2,
                    "Sale of real estate property (eg. Home, vacation home)": 3,
                    "Sale of depreciable properties": 4,
                    "Sale of bonds, debentures, promissory notes": 5,
                    "Sale of other properties": 6,
                    "Sale of personal-use property": 7,
                    "Sale of listed personal property": 8,
                    "Sale of shares of a private company": 9,
                    "Exchange one property for another": 10,
                    "Donates a property as a gift": 11,
                    "Settles a debt denominated in foreign currency": 12,
                    "Foreign exchange gain": 13,
                    "An option to buy or sell a property has expired": 14,
                    "Owns a property that was expropriated, stolen, or destroyed": 15,
                    "Owns a securities that a corporation redeems or cancels":16,
                    "Changes all or part of the property's use": 17
]
let Rental_Income = ["Income from rental property(eg.Vacation home, investment property, etc)":1]
let Business_and_Professional_Income = ["Income from business": 1,
                                        "Income from rendering professional services":2]
let Investment_Income = ["Annuities": 1,
                         "Life Insurance":2,
                         "Mutual Fund Income":3,
                         "Foreign Investment Income (and foreign tax credit)":4]
let Pension_Other_Income = ["Old Age Security":1,
                            "CPP benefits":2,
                            "Other Pension Income":3,
                            "Universal Child Care Benefit": 4,
                            "Canada Child Benefit":5,
                            "Employment Insurance":6,
                            "RRSP income":7,
                            "RDSP income": 8,
                            "Support payment":9,
                            "Worker's compensation": 10,
                            "Social assistance payments":11]
//=========================End of Income================================


//========================Deduction=====================================
let Deduction_subMenu = ["Computing Investment Income": 1,
                         "Capital Transactions": 2,
                         "Rental Property": 3,
                         "Business Income": 4,
                         "Other": 5]
let COMPUTINGINVESTMENTINCOME = 1
let CAPITALTRANSACTION = 2
let RENTALPROPERTY = 3
let BUSINESSINCOME = 4
let OTHER = 5
let Computing_Investment_Income = ["Investment counsel fees and custodial fees":1,
                                    "Fees paid for investment record-keeping":2,
                                    "Fees paid for investment administrative services":3,
                                    "Fees paid for investment advice on buying or selling investments":4,
                                    "Interest Expense": 5,
                                    "Fees paid for safety deposit box":6,
                                    "Fees paid for investment advice and administrative services for registered investments": 7,
                                    "Subscription fees paid for financial newspapers, magazines, or newsletters": 8,
                                    "Brokerage fees for buying and selling securities": 9]
let Capital_Transactions = ["Capital Loss":1,
                            "Allowable business investment loss":2]
let Rental_Property = ["Rental loss":1,
                        "Purchase of rental property":2,
                        "Purchase of funitures for rental property":3,
                        "Purchase of fixtures for rental property":4,
                        "Mortgage payment for rental property":5,
                        "Property taxes for rental property":6,
                        "Utility costs for rental property":7,
                        "Home insurance costs for rental property":8,
                        "Maintenance and repair costs for rental property":9,
                        "Advertising costs for rental property":10,
                        "Management fees for rental property":11,
                        "Other expenses paid for rental property":12,
                        "Legal fees for rental property":13,
                        "Accounting fees for rental property":14,
                        "Landscaping costs for rental property":15,
                        "Lease inducement paid on rental property":16,
                        "Costs on construction and renovation of a building":17]
let Business_Income = ["Meals and Entertainment":1,
                        "CCA":2,
                        "Eligible capital property":3]

let Deduction_Other = [ "Pension adjustment":1,
                        "Registered Pension Plan(RPP) deduction":2,
                        "Registered Retirement Savings Plan(RRSP) deduction":3,
                        "Union/professional dues":4,
                        "Universal Child Care Benefit repayment":5,
                        "Child care expense":6,
                        "Disability supports deduction":7,
                        "Business Investment loss":8,
                        "Moving expense":9,
                        "Carrying charges& interest expense":10,
                        "Canada Pension Plan(CPP) deduction for self-employment":11,
                        "Other employment expense":12,
                        "Other deductions":13,
                        "Social benefit repayment":14,
                        "Employee home relocation loan deduction":15,
                        "Security options deductions":16,
                        "Other payment deductions":17,
                        "Non-capital loss of other years":18,
                        "Net capital loss of other years":19,
                        "Capital gains deductions":20,
                        "Additional deductions":21,
                        "Meals & Entertainment": 22,
                        "Moving Expenses":23,
                        "Professional membership dues":24]
//========================End of Deduction=====================================



//========================Tax Credit==================================
let Credit_subMenu = ["CPP contribution through employment": 1,
                        "CPP contribution on self-employment":2,
                        "Employment Insurance (EI) premiums through employment":3,
                        "Employment Insurance (EI) premiums on self-employment":4,
                        "Adoption expense":5,
                        "Pension income amount":6,
                        "Caregiver amount":7,
                        "Disability amount":8,
                        "Interest paid on student loans":9,
                        "Tuition, education, and textbook amounts":10,
                        "Medical expense for self, spouse, and dependant children":11,
                        "Volunteer firefighters amounts":12,
                        "Canada employment amount":13,
                        "Public transit amount":14,
                        "Children's fitness amount":15,
                        "Family caregiver amount for children under 18 years of age":16,
                        "Home buyer's amount":17,
                        "Children art's amount":18,
                        "Search and rescue volunteer tax credit":19,
                        "Investment tax credit":20,
                        "Children's fitness tax credit":21,
                        "Age credit":22,
                        "Spouse credit":23]
//========================End of Tax==================================





//===================================================================
/*struct Menu{
    var title: String
    var instance: Formula
    var subMenu = [Menu]()
}

let TaxMenu =  Menu(title: "root", instance: nil, subMenu: [Income,
                                                            Deduction,
                                                            Credit])

let Income = Menu(title: "Income", instance: nil, subMenu: [Employment,
                                                            Dividend_Income,
                                                            Interest_Income,
                                                            Capital_Gain,
                                                            Rental_Income,
                                                            Business_and_Professional_Income,
                                                            Investment_Income,
                                                            Pension_Income])

let Employment = Menu(title: "Employment", instance: nil, subMenu:[E_I,E_PAVB, E_A, E_ER, E_S])
let E_I = Menu(title: "Employment Income", instance: nil, subMenu:[])
let E_PAVB = Menu(title: "Employer-provided Automobile and Vehicle Benefits", instance: nil, subMenu:[])
let E_A = Menu(title: "Allowances", instance: nil, subMenu:[])
let E_ER = Menu(title: "Expense Reimbursement", instance: nil, subMenu:[])
let E_S = Menu(title: "Stock Option", instance: nil, subMenu:[])


let Dividend_Income = Menu(title: "Dividend Income", instance: nil, subMenu: [])
let Interest_Income = Menu(title: "Interest Income", instance: nil, subMenu: [])
let Capital_Gain = Menu(title: "Capital Gain", instance: nil, subMenu: [])
let Rental_Income = Menu(title: "Rental Income", instance: nil, subMenu: [])
let Business_and_Professional_Income = Menu(title: "Business and Professional Income", instance: nil, subMenu: [])
let Investment_Income = Menu(title: "Investment Income", instance: nil, subMenu: [])
let Pension_Income = Menu(title: "Pension Income", instance: nil. subMenu:[])



let Deduction = Menu(title:"Deduction", instance: nil, subMenu:[])
let Credit = Menu(title:"Credit", instance: nil, subMenu:[])
*/