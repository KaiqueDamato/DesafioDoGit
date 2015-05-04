//
//  UserFactory.swift
//  DesafioGit
//
//  Created by Kaique Damato on 5/3/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit
import CoreData

class UserFactory: NSObject {
    
    static func createUser(username: String, password: String) {
        let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entidade = NSEntityDescription.entityForName("User", inManagedObjectContext: contexto!)
        let user = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! User
        
        user.login = username
        user.password = password
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
}
