//
//  FavTextArray+CoreDataProperties.swift
//  EBikeV1-TestA
//
//  Created by Rick Mc on 9/16/18.
//  Copyright © 2018 Rick Mc. All rights reserved.
//
//

import Foundation
import CoreData


extension FavTextArray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavTextArray> {
        return NSFetchRequest<FavTextArray>(entityName: "FavTextArray")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
