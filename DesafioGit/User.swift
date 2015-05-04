//
//  User.swift
//  
//
//  Created by Kaique Damato on 5/3/15.
//
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {

    @NSManaged var login: String
    @NSManaged var password: String
    @NSManaged var repositories: Repository

}
