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
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //request.predicate = NSPredicate()
        request.returnsObjectsAsFaults = false
       // request.fetchLimit = defaultFetchSize
        do{
            let results =  try context.fetch(request) as! [User]
            //print(results[0].getLastname())
            return results
        } catch {
            fatalError("Fetch Failed")
        }
    }
    static func fetch_records() -> [Record]{
        //let defaultFetchSize = 1
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        //request.predicate = NSPredicate()
        request.returnsObjectsAsFaults = false
        // request.fetchLimit = defaultFetchSize
        do{
            let results =  try context.fetch(request) as! [Record]
            return results
        } catch {
            fatalError("Fetch Failed")
        }

    }
}
