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

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?){
        super.init(entity:entity, insertIntoManagedObjectContext: context)
    }
    init?(key: String, value: Double){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("Value", inManagedObjectContext:context)
        if let entity = entity {
            super.init(entity: entity, insertIntoManagedObjectContext: context)
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
    private func setKey(key: String){
        self.key = key
    }
    private func setValue(value: Double){
        self.value = value
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
                context.deleteObject(self)
                do {
                    try context.save()
                    
                } catch {
                    print("ERROR: fail to delete a value")
                }
            }
    }
}
