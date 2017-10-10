//
//  CoreDataSaver.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-21.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData



class CoreDataSaver {
    
static func save_a_user (_ firstname: String, _ lastname : String, _ province: String, _ marital: Bool, _ income: Double ){
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context : NSManagedObjectContext = appDel.managedObjectContext
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
    newUser.setValue(firstname, forKey:"firstname")
    newUser.setValue(lastname, forKey:"lastname" )
    newUser.setValue(province, forKey: "province")
    newUser.setValue(marital, forKey: "maritalstatus")
    newUser.setValue(income,forKey: "income")
    do{
        try context.save()
    } catch {
        print("Saving a user occurs an error")
    }
    
 }
  static func save_a_user_withUser(_ user: User){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(user.firstname, forKey:"firstname")
        newUser.setValue(user.lastname, forKey:"lastname" )
        newUser.setValue(user.province, forKey: "province")
        newUser.setValue(user.maritalstatus, forKey: "maritalstatus")
        newUser.setValue(user.income,forKey: "income")
        do{
            try context.save()
        } catch {
            print("Saving a user occurs an error, with user func")
        }
        
    }
    static func save_a_value(_ value: Value){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Value", into: context)
        newValue.setValue(value.key, forKey: "key")
        newValue.setValue(value.value, forKey: "value")
        do {
            try context.save()
        } catch {
            print("Saving a value occurs an error")
        }
    }
    
}
