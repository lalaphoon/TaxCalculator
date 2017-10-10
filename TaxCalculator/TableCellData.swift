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
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init?(first: String, second: String, third: String, forth: String){
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "TableCellData", in: context)
        if let entity =  entity {
            super.init(entity:entity, insertInto: context)
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
    fileprivate func setFirst(_ first: String){
        self.first = first
    }
    fileprivate func setSecond(_ second: String){
        self.second = second
    }
    fileprivate func setThird(_ third: String){
        self.third = third
    }
    fileprivate func setForth(_ forth: String){
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
            context.delete(self)
            do {
                try context.save()
                
            } catch {
                print("ERROR: fail to delete a TableCellData")
            }
        }
    }
}
