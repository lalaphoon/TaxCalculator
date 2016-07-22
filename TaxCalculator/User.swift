//
//  User.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-21.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData


class User : NSManagedObject {
   
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init?(firstname: String, lastname: String, province: String, income: Double, marital: Bool){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext =  appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: context)
        if let entity = entity {
            super.init(entity: entity, insertIntoManagedObjectContext: context)
            setFirstname(firstname)
            setLastname(lastname)
            setProvince(province)
            setIncome(income)
            setMaritalStatus(marital)
            
        }else {
            super.init()
            print("Error:entity not found for User")
            return nil
        }
    }
    
    
    //========================Setter===============================
   private func setProvince(province: String){
        self.province = province
    }
   private func setFirstname(first: String){
        self.firstname = first
    }
   private func setLastname(last: String){
        self.lastname = last
    }
   private func setMaritalStatus(m: Bool){
        self.maritalstatus = m
    }
   private func setIncome(income :  Double){
        self.income = income
    }
    //=========================Getter==============================
    func getIncome() -> Double {
        return self.income
    }
    func getFirstname() -> String{
        return self.firstname
    }
    func getLastname() -> String {
        return self.lastname
    }
    func getProvince() -> String{
        return self.province
    }
    func getMaritalStatus() -> Bool{
        return self.maritalstatus
    }

}
