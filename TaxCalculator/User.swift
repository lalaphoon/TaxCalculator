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
   
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init?(firstname: String, lastname: String, province: String, income: Double, marital: String){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext =  appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        if let entity = entity {
            super.init(entity: entity, insertInto: context)
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
   fileprivate func setProvince(_ province: String){
        self.province = province
    }
   fileprivate func setFirstname(_ first: String){
        self.firstname = first
    }
   fileprivate func setLastname(_ last: String){
        self.lastname = last
    }
   fileprivate func setMaritalStatus(_ m: String){
        self.maritalstatus = m
    }
   fileprivate func setIncome(_ income :  Double){
    self.income = NSNumber(value: income as Double)
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
    func delete() -> Bool {
        if let context = self.managedObjectContext {
            context.delete(self)
            do {
                try context.save()
                return true
            } catch {
                print("ERROR: fail to delete a user")
            }
        }
        return false
    }
    
    
    /*
    
    你好
*/
    
    
    
    
    
    

}
