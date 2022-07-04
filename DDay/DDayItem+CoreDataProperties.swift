//
//  DDayItem+CoreDataProperties.swift
//  DDay
//
//  Created by Hoju Choi on 2022/07/04.
//
//

import Foundation
import CoreData


extension DDayItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDayItem> {
        return NSFetchRequest<DDayItem>(entityName: "DDayItem")
    }

    @NSManaged public var reminders: [Int]?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?

}

extension DDayItem : Identifiable {
    public typealias ID = String
    public var id: ID {
        "\(String(describing: title))_\(String(describing: timestamp))_\(String(describing: reminders))"
    }
    
}
