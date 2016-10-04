//
//  TableCellData.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-02.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData


class TableCellData: NSManagedObject {
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    init?(first: String, second: String, third: String, forth: String){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("TableCellData", inManagedObjectContext: context)
        if let entity =  entity {
            super.init(entity:entity, insertIntoManagedObjectContext: context)
            setFirst(first)
            setSecond(second)
            setThird(third)
            setForth(forth)
            print("Saving a TableCellData")
        } else {
            super.init()
            print("Error: entity not found for Record")
            return nil
        }
    }
    //=============setter=========================
    private func setFirst(first: String){
        self.first = first
    }
    private func setSecond(second: String){
        self.second = second
    }
    private func setThird(third: String){
        self.third = third
    }
    private func setForth(forth: String){
        self.forth = forth
    }
    //===============End of setter================
    //===============getter=======================
    func getFirst() -> String{
        return self.first!
    }
    func getSecond() -> String {
        return self.second!
    }
    func getThird() -> String {
        return self.third!
    }
    func getForth() -> String {
        return self.forth!
    }
    //===============End of getter================
    func save(){
        if let context = self.managedObjectContext{
            do {
                try context.save()
            } catch {
                print("error: failed to save a table cell data")
            }
        }
    }
    func delete() {
        if let context = self.managedObjectContext {
            context.deleteObject(self)
            do {
                try context.save()
                
            } catch {
                print("ERROR: fail to delete a TableCellData")
            }
        }
    }
}
