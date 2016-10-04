//
//  Record.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-02.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData


class Record: NSManagedObject {

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    init?(title: String, descrip: String, helpInstruction: String){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("Record", inManagedObjectContext: context)
        if let entity =  entity {
            super.init(entity:entity, insertIntoManagedObjectContext: context)
            setTitle(title)
            setDescription(descrip)
            setHelp(helpInstruction)
            print("Saving a record")
        } else {
            super.init()
            print("Error: entity not found for Record")
            return nil
        }
    }
    
    //=================setter======================
    private func setTitle(title: String){
        self.title = title
    }
    private func setDescription(description: String){
        self.descrip = description
    }
    private func setHelp(helpInstruction: String){
        self.help = helpInstruction
    }
    //=================End of setter===============
    //=================Getter======================
    func getTitle() -> String {
        return self.title!
    }
    func getDescription() -> String {
        return self.descrip!
    }
    func getHelp() -> String {
        return self.help!
    }
    //================End of getter===============
    //================Attach Objects===============
    func addValueObject(value: Value){
        var items = self.mutableOrderedSetValueForKey("values")
        items.addObject(value)
    }
    func removeValueObject(value: Value){
        var items = self.mutableOrderedSetValueForKey("values")
        items.addObject(value)
    }
    func attachValueSet(value: [Value]){
        var items = self.mutableOrderedSetValueForKey("values")
        for i in value {
            items.addObject(i)
        }
    }
    func attachTableDataSet(tableDatas: [TableCellData]){
        var items = self.mutableOrderedSetValueForKey("tableData")
        for i in tableDatas {
            items.addObject(i)
        }
    }
    //================End of Object===============
    func save() {
        if let context = self.managedObjectContext {
            do {
                try context.save()
            } catch {
                print("ERROR: FAILED TO SAVE A KEYVALUE PAIR")
            }
        }
    }

}
