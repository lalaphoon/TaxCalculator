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
    
    init?(firstname: String, lastname: String, province: String, income: Double, marital: String){
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
            print("Saving a user is done")
            
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
   private func setMaritalStatus(m: String){
        self.maritalstatus = m
    }
   private func setIncome(income :  Double){
    self.income = NSNumber(double: income)
    }
    //=========================Getter==============================
    func getIncome() -> Double {
        return Double(self.income)
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
    func getMaritalStatus() -> String{
        return self.maritalstatus
    }
    //=========
    func save(){
        if let context = self.managedObjectContext {
            do {
                try context.save()
            } catch {
                print("ERROR: fail to save a user")
            }
        }
    }
   /* func delete() -> Bool {
        if let context = self.managedObjectContext {
            let containedMoment = self.mutableSetValueForKey("containedMoment")
            for item in containedMoment {
                if let moment = item as? Moment, uncategorize = Category.getUncategorized() {
                    moment.setMomentCategory(uncategorize)
                }
            }
            
            context.deleteObject(self)
            do {
                try context.save()
                return true
            } catch {
                print("ERROR: fail to delete category")
            }
        }
        return false
    }*/

}
