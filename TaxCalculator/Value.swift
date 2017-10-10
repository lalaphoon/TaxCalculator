//
//  Value.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-02.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData


class Value: NSManagedObject {

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?){
        super.init(entity:entity, insertInto: context)
    }
    init?(key: String, value: Double){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Value", in:context)
        if let entity = entity {
            super.init(entity: entity, insertInto: context)
            setKey(key)
            setValue(value)
            print("Saving a pair of value")
        } else {
            super.init()
            print("Error: entity not found for Value")
            return nil
        }
    }
    //=============setter=======================
    fileprivate func setKey(_ key: String){
        self.key = key
    }
    fileprivate func setValue(_ value: Double){
        self.value = value as NSNumber
    }
    //=============End of setter=================
    //=============getter========================
    func getKey()->String{
        return self.key!
    }
    func getValue()->Double{
        return Double(self.value!)
    }
    //=============End of getter=================
    //======================Attach Object========
    
    //===========================================
    func save() {
        if let context = self.managedObjectContext {
            do {
                try context.save()
            } catch {
                print("ERROR: FAILED TO SAVE A KEYVALUE PAIR")
            }
        }
    }
    func delete() {
            if let context = self.managedObjectContext {
                context.delete(self)
                do {
                    try context.save()
                    
                } catch {
                    print("ERROR: fail to delete a value")
                }
            }
    }
}
