//
//  Repository.swift
//  
//
//  Created by Kaique Damato on 5/3/15.
//
//

import Foundation
import CoreData

@objc(Repository)
class Repository: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var labels: NSMutableSet
    @NSManaged var users: User
    
    func addLabel(label: Label) {
        labels.addObject(label)
        label.repositories = self
    }

}
