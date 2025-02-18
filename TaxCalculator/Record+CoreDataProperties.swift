//
//  Record+CoreDataProperties.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-02.
//  Copyright © 2016 WTC Tax. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record {

    @NSManaged var descrip: String?
    @NSManaged var help: String?
    @NSManaged var title: String?
    @NSManaged var tableData: NSOrderedSet?
    @NSManaged var values: NSOrderedSet?

}
