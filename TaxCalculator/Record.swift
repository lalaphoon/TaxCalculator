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

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init?(title: String, descrip: String, helpInstruction: String){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Record", in: context)
        if let entity =  entity {
            super.init(entity:entity, insertInto: context)
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
    fileprivate func setTitle(_ title: String){
        self.title = title
    }
    fileprivate func setDescription(_ description: String){
        self.descrip = description
    }
    fileprivate func setHelp(_ helpInstruction: String){
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
    func getValues() -> [Value]{
        //reference: http://stackoverflow.com/questions/30690582/getting-objects-from-to-many-relationship-in-swift-core-data
        let result = self.values?.array as! [Value]
        return result
    }
    func getTableDatas() -> [TableCellData] {
        let result = self.tableData?.array as! [TableCellData]
        return result
    }
    //================End of getter===============
    //================Attach Objects===============
    func addValueObject(_ value: Value){
        let items = self.mutableOrderedSetValue(forKey: "values")
        items.add(value)
    }
    func removeValueObject(_ value: Value){
        let items = self.mutableOrderedSetValue(forKey: "values")
        items.add(value)
    }
    func attachValueSet(_ value: [Value]){
        let items = self.mutableOrderedSetValue(forKey: "values")
        for i in value {
            items.add(i)
        }
    }
    func attachTableDataSet(_ tableDatas: [TableCellData]){
        let items = self.mutableOrderedSetValue(forKey: "tableData")
        for i in tableDatas {
            items.add(i)
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
    func delete() {
        //reference : http://stackoverflow.com/questions/28374922/core-data-with-swift-how-to-delete-object-from-relationship-entity
        if let context = self.managedObjectContext {
            let containedValues = self.mutableOrderedSetValue(forKey: "values")
            let containedTableDatas = self.mutableOrderedSetValue(forKey: "tableData")
            for item in containedValues {
                context.delete(item as! Value)
            }

            for item in containedTableDatas {
               context.delete(item as! TableCellData)
            }
            
            context.delete(self)
            do {
                try context.save()
                
            } catch {
                print("ERROR: fail to delete a value")
            }
        }
    }

}
