//
//  CoreDataFetcher.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-21.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFetcher {
   static func fetch_a_user() -> [User]{
        //let defaultFetchSize = 1
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "User")
        //request.predicate = NSPredicate()
        request.returnsObjectsAsFaults = false
       // request.fetchLimit = defaultFetchSize
        do{
            let results =  try context.executeFetchRequest(request) as! [User]
            //print(results[0].getLastname())
            return results
        } catch {
            fatalError("Fetch Failed")
        }
    }
    static func fetch_records() -> [Record]{
        //let defaultFetchSize = 1
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Record")
        //request.predicate = NSPredicate()
        request.returnsObjectsAsFaults = false
        // request.fetchLimit = defaultFetchSize
        do{
            let results =  try context.executeFetchRequest(request) as! [Record]
            return results
        } catch {
            fatalError("Fetch Failed")
        }

    }
}
