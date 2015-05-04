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
    @NSManaged var labels: Label
    @NSManaged var users: User

}
