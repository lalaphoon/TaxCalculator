//
//  ProvincialTaxPro.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2017-01-13.
//  Copyright © 2017 WTC Tax. All rights reserved.
//

import Foundation
protocol ProvincialTax {
    func getRRSP(netIncome: Double, _ contribution: Double ) -> (result:Double, process: [[String]])
    func getInterestIncome(netIncome: Double, _ interestIncome : Double) -> (result:Double , process: [[String]])
    func getOldAgePension(netIncome: Double, _ OASPension: Double, _ OASClawback: Double) -> (result: Double, process: [[String]])
    func getForeignInvestmentIncome(netIncome: Double, foreignIncome: Double, foreignTaxPaid: Double, isUSStock: Bool) -> (result:Double, process: [[String]])
    func getDividendIncome(netIncome: Double, dividendIncome: Double, ForeignTaxPaid: Double, CanadianCorporation : Bool, StockMarket : Bool, isUSStock : Bool, dividF: Double, dividP: Double) -> (result: Double, process: [[String]])
    
    func getBasicReduction(A: Double , _ B: Double, _ special: Bool , _ di: Double  ) -> Double
   // func getHealthPremium(A: Double, _ B: Double) -> Double
    func getProvincialCredit(A : Double, _ B: Double) -> Double
    func getForeignTaxCredit(income: Double, _ foreignIncome: Double, _ Deduction_2012 : Double, _ Deduction_2011 : Double, _ FederalForeignTaxCredit: Double, _ ProvincialForeignTaxCredit: Double, _ mode: Location,  _ extraDividend : Double ) -> Double
    //func getDividendTaxCredit(netIncome : Double, dividendIncome : Double, mode: Location, CanadianCorporation : Bool, StockMarket : Bool) -> Double
}
enum CurrentProvince {
    static func getData(province: Location) -> ProvincialTax? {
        switch province {
            case .Ontario :
                return OntarioTax()
            case .Alberta :
                return AlbertaTax()
            case .British_Columbia :
                return BritishColumbiaTax()
        default:
                return nil
        }
    }
}

