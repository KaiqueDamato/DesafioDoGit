//
//  User.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    
    @NSManaged var login: String
    @NSManaged var password: String
    @NSManaged var repositories: NSSet
    
    func addRepository(repository:Repository) {
        var repositories = self.mutableSetValueForKey("repositories")
        repositories.addObject(repository)
    }
}
