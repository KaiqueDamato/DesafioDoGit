//
//  Repository.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import Foundation
import CoreData

@objc(Repository)
class Repository: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var user: User
    @NSManaged var labels: NSSet
    
    func addLabel(label:Label) {
        var labels = self.mutableSetValueForKey("labels")
        labels.addObject(label)
    }
}
