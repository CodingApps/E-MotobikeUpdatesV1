//
//  FavTextArray+CoreDataProperties.swift
//  EBikeV1-TestA
//
//  Open Source
//
//  Copyright © 2022 Rick
//
//  Open Source, The MIT License (MIT)
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
