//
//  User+CoreDataProperties.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-21.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
import CoreData

extension User{
    @NSManaged internal var firstname: String
    @NSManaged internal var lastname: String
    @NSManaged internal var province: String
    @NSManaged internal var income: Double
    @NSManaged internal var maritalstatus: Bool

}
