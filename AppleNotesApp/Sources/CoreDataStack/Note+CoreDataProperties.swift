//
//  Note+CoreDataProperties.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 10.10.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var bodyText: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
