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
class Menu {
    var name : String
    var category : Int
    var topic : Int
    var id: Int
    //var formula: Formula
    init(category: Int,  topic: Int,  name: String, id : Int){
        self.name = name
        self.category = category
        self.topic = topic
        self.id = id
    }
    /*
    init(category: Int, _ topic: Int, _ name: String, _ formula){
        self.name = name
        self.category = category
        self.topic = topic
        self.formula = formula
    }
    */

}



let ERROR = "ERROR"

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
let taxMenuBook = [
    Menu(category: INCOME, topic: EMPLOYMENT, name:"Employment income", id: 1),
    Menu(category: INCOME, topic: EMPLOYMENT, name: "Employer-provided automobile and vehicle benefits", id: 2),
    Menu(category: INCOME, topic: EMPLOYMENT, name: "Allowances", id: 3),
    Menu(category: INCOME, topic: EMPLOYMENT, name: "Expense reimbursement", id: 4),
    Menu(category: INCOME, topic: EMPLOYMENT, name: "Stock option", id: 5),
    
    
    Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Dividend income from securities(stock, mutual funds, etc.)", id: 1),
    Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Dividend income business", id: 2),
     Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Dividend income (non-eligible only)", id: 3),
     Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Dividend income from TFSA", id: 4),
     Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Dividend income from RRSP", id: 5),
     Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Other types of dividend income", id: 6),
     Menu(category: INCOME, topic: DIVIDENDINCOME, name: "Capital Gains Dividends", id: 7),
    
    
    
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from bank deposits", id: 1),
    Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from money loaned", id: 2),
    Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from bonds", id: 3),
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from GIC", id: 4),
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from Treasury Bills", id: 5),
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from TFSA", id: 6),
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Interest income from RRSP", id: 7),
     Menu(category: INCOME, topic: INTERESTINCOME, name: "Other types of interest income", id: 8),
    
    
    
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of publicly traded shares(eg.Stock market trading)", id: 1),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of mutual fund units", id: 2),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of real estate property(eg. Home, vacation home)", id: 3),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of depreciable properties", id: 4),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of bonds, debentures, promissory notes", id: 5),
Menu(category: INCOME, topic: CAPITALGAIN, name: "ale of other properties", id: 6),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of personal-use property", id: 7),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of listed personal property", id: 8),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Sale of shares of a private company", id: 9),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Exchange one property for another", id: 10),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Donates a property as a gift", id: 11),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Settles a debt denominated in foreign currency", id: 12),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Foreign exchange gain", id: 13),
Menu(category: INCOME, topic: CAPITALGAIN, name: "An option to buy or sell a property has expired", id: 14),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Owns a property that was expropriated, sholen, or destroyed", id: 15),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Owns a securities that a corporation redeems or cancels", id: 16),
Menu(category: INCOME, topic: CAPITALGAIN, name: "Changes all or part of the property's use", id: 17),

Menu(category: INCOME, topic: RENTALINCOME, name: "Income from rental property(eg. Vacation home, investment property, etc.)", id: 1),

Menu(category: INCOME, topic: BUSINESSANDPROFESSIONALINCOME, name: "Income from Business", id: 1),
Menu(category: INCOME, topic: BUSINESSANDPROFESSIONALINCOME, name: "Income from rendering professional services", id: 2),

Menu(category: INCOME, topic: INVESTMENTINCOME, name: "Annuities", id: 1),
Menu(category: INCOME, topic: INVESTMENTINCOME, name: "Life Insurance", id: 2),
Menu(category: INCOME, topic: INVESTMENTINCOME, name: "Mutual Fund income", id: 3),
Menu(category: INCOME, topic: INVESTMENTINCOME, name: "Foreign investment income(and foreign tax credit)", id: 4),

Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Old Age Security", id: 1),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "CPP benefits", id: 2),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Other pension income", id: 3),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Universal Child Care Benefit", id: 4),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Canada Child Benefit", id: 5),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Employment insurance", id: 6),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "RRSP income", id: 7),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "RDSP income", id: 8),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Support payment", id: 9),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Worker's compensation", id: 10),
Menu(category: INCOME, topic: PENSIONOTHERINCOME, name: "Social assistance payments", id: 11),

Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Investment counsel fees and custodial fees", id: 1),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Fees paid for investment record-keeping", id: 2),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Fees paid for investment administrative services", id: 3),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Fees paid for investment advice on buying or selling investments", id: 4),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Interest Expense", id: 5),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Fees paid for safety deposit box", id: 6),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Fees paid for investment advice and administrative services for registered investments(RRSP, TFSAs, RPPs, etc.)", id: 7),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Subscription fees paid for financial newspapers, magazines or newsletters", id: 8),
Menu(category: DEDUCTION, topic: COMPUTINGINVESTMENTINCOME, name: "Brokerage fees for buying and selling securites", id: 9),
    
    
Menu(category: DEDUCTION, topic: CAPITALGAIN, name: "Capital loss", id: 1),
Menu(category: DEDUCTION, topic: CAPITALGAIN, name: "Allowable business investment loss", id: 2),
    
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Rental loss", id: 1),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Purchase of rental property", id: 2),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Purchase of furnitures for rental property", id: 3),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Purchase of fixtures for rental property", id: 4),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Mortgage payment for rental property", id: 5),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Property taxes for rental property", id: 6),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Utility costs for rental property", id: 7),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Home insurance costs for rental property", id: 8),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Maintenance and repaire costs for rental property", id: 9),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Other expenses paid for rental property", id: 10),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Legal fees for rental property", id: 11),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Accounting fees for rental property", id: 12),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Landscaping costs for rental property", id: 13),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Lease inducement paid on rental property", id: 14),
Menu(category: DEDUCTION, topic: RENTALPROPERTY, name: "Costs on construction and renovation of a building", id: 15),
Menu(category: DEDUCTION, topic: BUSINESSINCOME, name: "Meals and Entertainment", id: 1),
Menu(category: DEDUCTION, topic: BUSINESSINCOME, name: "CCA", id: 2),
Menu(category: DEDUCTION, topic: BUSINESSINCOME, name: "Eligible capital property", id: 3),
    
Menu(category: DEDUCTION, topic: OTHER, name: "Pension adjustment", id: 1),
Menu(category: DEDUCTION, topic: OTHER, name: "Registered Pension Plan(RPP)deduction", id: 2),
Menu(category: DEDUCTION, topic: OTHER, name: "Registered Retirement Savings Plan(RRSP) deduction", id: 3),
Menu(category: DEDUCTION, topic: OTHER, name: "Union/Professinal dues", id: 4),
Menu(category: DEDUCTION, topic: OTHER, name: "Universal Child Care Benefit repaymet", id: 5),
Menu(category: DEDUCTION, topic: OTHER, name: "Child care expense", id: 6),
Menu(category: DEDUCTION, topic: OTHER, name: "Disability supports deduction", id: 7),
Menu(category: DEDUCTION, topic: OTHER, name: "Business investment loss", id: 8),
Menu(category: DEDUCTION, topic: OTHER, name: "Moving expense", id: 9),
Menu(category: DEDUCTION, topic: OTHER, name: "Carrying charges & interest expense", id: 10),
Menu(category: DEDUCTION, topic: OTHER, name: "Canada Pension Plan(CPP) deduction for self-employment", id: 11),
Menu(category: DEDUCTION, topic: OTHER, name: "Other employment expense", id: 12),
Menu(category: DEDUCTION, topic: OTHER, name: "Other deductions", id: 13),
Menu(category: DEDUCTION, topic: OTHER, name: "Social benefit repayment", id: 14),
Menu(category: DEDUCTION, topic: OTHER, name: "Employee home relocation loan deduction", id: 15),
Menu(category: DEDUCTION, topic: OTHER, name: "Security options deductions", id: 16),
Menu(category: DEDUCTION, topic: OTHER, name: "Other payment deductions", id: 17),
Menu(category: DEDUCTION, topic: OTHER, name: "Non-capital loss of other years", id: 18),
Menu(category: DEDUCTION, topic: OTHER, name: "Net capital loss of other years", id: 19),
Menu(category: DEDUCTION, topic: OTHER, name: "Capital gains deductions", id: 20),
Menu(category: DEDUCTION, topic: OTHER, name: "Additional deductions", id: 21),
Menu(category: DEDUCTION, topic: OTHER, name: "Meals & Entertainment", id: 22),
Menu(category: DEDUCTION, topic: OTHER, name: "Moving expenses", id: 23),
Menu(category: DEDUCTION, topic: OTHER, name: "Professional membership dues", id: 24),
    
Menu(category: TAXCREDIT, topic: 0, name: "CPP contribution through employment", id: 1),
Menu(category: TAXCREDIT, topic: 0, name: "CPP contribution on self-employment", id: 2),
    Menu(category: TAXCREDIT, topic: 0, name: "Employment insurance(EI) premiums through employment", id: 3),
    Menu(category: TAXCREDIT, topic: 0, name: "Employment insurance(EI) premiums on self-employment", id: 4),
    Menu(category: TAXCREDIT, topic: 0, name: "Adoption expense", id: 5),
    Menu(category: TAXCREDIT, topic: 0, name: "Pension income amount", id: 6),
    Menu(category: TAXCREDIT, topic: 0, name: "Caregiver amount", id: 7),
    Menu(category: TAXCREDIT, topic: 0, name: "Disability amount", id: 8),
    Menu(category: TAXCREDIT, topic: 0, name: "Interest paid on student loans", id: 9),
    Menu(category: TAXCREDIT, topic: 0, name: "Tuition, education, and textbook amounts", id: 10),
    Menu(category: TAXCREDIT, topic: 0, name: "Medical expense for self, spouse, and dependant children", id: 11),
    Menu(category: TAXCREDIT, topic: 0, name: "Volunteer firefighters' amounts", id: 12),
    Menu(category: TAXCREDIT, topic: 0, name: "Canada employment amount", id: 13),
    Menu(category: TAXCREDIT, topic: 0, name: "Public transit amount", id: 14),
    Menu(category: TAXCREDIT, topic: 0, name: "Children's fitness amount", id: 15),
    Menu(category: TAXCREDIT, topic: 0, name: "Family caregiver amount for children under 18 years of age", id: 16),
    Menu(category: TAXCREDIT, topic: 0, name: "Home buyer's amount", id: 17),
    Menu(category: TAXCREDIT, topic: 0, name: "Children art's amount", id: 18),
    Menu(category: TAXCREDIT, topic: 0, name: "Search and rescue volunteer tax credit", id: 19),
    Menu(category: TAXCREDIT, topic: 0, name: "Home accessbility tax credit", id: 20),
    Menu(category: TAXCREDIT, topic: 0, name: "Investment tax credit", id: 21),
    Menu(category: TAXCREDIT, topic: 0, name: "Children's fitness tax credit", id: 22),
    Menu(category: TAXCREDIT, topic: 0, name: "Age credit", id: 23),
    Menu(category: TAXCREDIT, topic: 0, name: "Spouse credit", id: 24)
]


let taxBook = [
"1-1-1": "Employment income",
"1-1-2": "Employer-provided automobile and vehicle benefits",
"1-1-3": "Allowances",
"1-1-4": "Expense reimbursement",
"1-1-5": "Stock option",
"1-2-1": "Dividend income from securities(stock, mutual funds, etc.)",
"1-2-2": "Dividend income business",
"1-2-3": "Dividend income (non-eligible only)",
"1-2-4": "Dividend income from TFSA",
"1-2-5": "Dividend income from RRSP",
"1-2-6": "Other types of dividend income",
"1-2-7": "Capital Gains Dividends",
"1-3-1": "Interest income from bank deposits",
"1-3-2": "Interest income from money loaned",
"1-3-3":"Interest income from bonds",
"1-3-4":"Interest income from GIC",
"1-3-5":"Interest income from Treasury Bills",
"1-3-6": "Interest income from TFSA",
"1-3-7":"Interest income from RRSP",
"1-3-8":"Other types of interest income",
"1-4-1": "Sale of publicly traded shares(eg.Stock market trading)",
"1-4-2": "Sale of mutual fund units",
"1-4-3":"Sale of real estate property(eg. Home, vacation home)",
"1-4-4":"Sale of depreciable properties",
"1-4-5":"Sale of bonds, debentures, promissory notes",
"1-4-6":"Sale of other properties",
"1-4-7":"Sale of personal-use property",
"1-4-8":"Sale of listed personal property",
"1-4-9":"Sale of shares of a private company",
"1-4-10":"Exchange one property for another",
"1-4-11":"Donates a property as a gift",
"1-4-12":"Settles a debt denominated in foreign currency",
"1-4-13":"Foreign exchange gain",
"1-4-14":"An option to buy or sell a property has expired",
"1-4-15":"Owns a property that was expropriated, sholen, or destroyed",
"1-4-16":"Owns a securities that a corporation redeems or cancels",
"1-4-17":"Changes all or part of the property's use",
"1-5-1":"Income from rental property(eg. Vacation home, investment property, etc.)",
"1-6-1":"Income from Business",
"1-6-2":"Income from rendering professional services",
"1-7-1":"Annuities",
"1-7-2":"Life Insurance",
"1-7-3":"Mutual Fund income",
"1-7-4":"Foreign investment income(and foreign tax credit)",
"1-8-1":"Old Age Security",
"1-8-2":"CPP benefits",
"1-8-3":"Other pension income",
"1-8-4":"Universal Child Care Benefit",
"1-8-5":"Canada Child Benefit",
"1-8-6":"Employment insurance",
"1-8-7":"RRSP income",
"1-8-8":"RDSP income",
"1-8-9":"Support payment",
"1-8-10":"Worker's compensation",
"1-8-11":"Social assistance payments",

"2-1-1": "Investment counsel fees and custodial fees",
"2-1-2":"Fees paid for investment record-keeping",
"2-1-3":"Fees paid for investment administrative services",
"2-1-4":"Fees paid for investment advice on buying or selling investments",
"2-1-5":"Interest Expense",
"2-1-6":"Fees paid for safety deposit box",
"2-1-7":"Fees paid for investment advice and administrative services for registered investments(RRSP, TFSAs, RPPs, etc.)",
"2-1-8":"Subscription fees paid for financial newspapers, magazines or newsletters",
"2-1-9":"Brokerage fees for buying and selling securites",

"2-2-1":"Capital loss",
"2-2-2":"Allowable business investment loss",
    
    
"2-3-1":"Rental loss",
"2-3-2":"Purchase of rental property",
"2-3-3":"Purchase of furnitures for rental property",
"2-3-4":"Purchase of fixtures for rental property",
"2-3-5":"Mortgage payment for rental property",
"2-3-6":"Property taxes for rental property",
"2-3-7":"Utility costs for rental property",
"2-3-8":"Home insurance costs for rental property",
"2-3-9":"Maintenance and repaire costs for rental property",
"2-3-10":"Other expenses paid for rental property",
"2-3-11":"Legal fees for rental property",
"2-3-12":"Accounting fees for rental property",
"2-3-13":"Landscaping costs for rental property",
"2-3-14":"Lease inducement paid on rental property",
"2-3-15": "Costs on construction and renovation of a building",
    
    
"2-4-1":"Meals and Entertainment",
"2-4-2":"CCA",
"2-4-3":"Eligible capital property",
    
    
"2-5-1":"Pension adjustment",
"2-5-2":"Registered Pension Plan(RPP)deduction",
"2-5-3":"Registered Retirement Savings Plan(RRSP) deduction",
"2-5-4":"Union/Professinal dues",
"2-5-5":"Universal Child Care Benefit repaymet",
"2-5-6":"Child care expense",
"2-5-7":"Disability supports deduction",
"2-5-8":"Business investment loss",
"2-5-9":"Moving expense",
"2-5-10":"Carrying charges & interest expense",
"2-5-11":"Canada Pension Plan(CPP) deduction for self-employment",
"2-5-12":"Other employment expense",
"2-5-13":"Other deductions",
"2-5-14":"Social benefit repayment",
"2-5-15":"Employee home relocation loan deduction",
"2-5-16":"Security options deductions",
"2-5-17":"Other payment deductions",
"2-5-18":"Non-capital loss of other years",
"2-5-19":"Net capital loss of other years",
"2-5-20":"Capital gains deductions",
"2-5-21":"Additional deductions",
"2-5-22":"Meals & Entertainment",
"2-5-23":"Moving expenses",
"2-5-24":"Professional membership dues",
    
    
    
"3-1-":"CPP contribution through employment",
"3-2-":"CPP contribution on self-employment",
"3-3-":"Employment insurance(EI) premiums through employment",
"3-4-":"Employment insurance(EI) premiums on self-employment",
"3-5-":"Adoption expense",
"3-6-":"Pension income amount",
"3-7-":"Caregiver amount",
"3-8-":"Disability amount",
"3-9-":"Interest paid on student loans",
"3-10-":"Tuition, education, and textbook amounts",
"3-11-":"Medical expense for self, spouse, and dependant children",
"3-12-":"Volunteer firefighters' amounts",
"3-13-":"Canada employment amount",
"3-14-":"Public transit amount",
"3-15-":"Children's fitness amount",
"3-16-":"Family caregiver amount for children under 18 years of age",
"3-17-":"Home buyer's amount",
"3-18-":"Children art's amount",
"3-19-":"Search and rescue volunteer tax credit",
"3-20-":"Home accessbility tax credit",
"3-21-":"Investment tax credit",
"3-22-":"Children's fitness tax credit",
"3-23-":"Age credit",
"3-24-":"Spouse credit"]

extension TaxPro{
    func lookForOption(index: String) -> String{
        if taxBook[index] != nil{
            return taxBook[index]!
        } else
        {        return ERROR
        }
    }
    func lookForTopic(category: Int, _ topic: Int) ->[String]{
        let index = String(category) + "-" + String(topic) + "-"
        var result = [String]()
        var count = 0
        for item in taxBook{
            if item.0.hasPrefix(index) {
                
               result.insert( item.1, atIndex: count)
                count+=1
              
            }
        }
        return result
    }
    func lookForCategory(category: Int) ->[String]{
        let index = String(category) + "-"
        var result = [String]()
        var count = 0
        for item in taxBook{
            if item.0.hasPrefix(index){
                result.insert(item.1, atIndex: count)
                count += 1
            }
        }
        return result
    }
    
    
}



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