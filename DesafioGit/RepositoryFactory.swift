//
//  RepositoryFactory.swift
//  DesafioGit
//
//  Created by Kaique Damato on 5/3/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit
import CoreData

class RepositoryFactory: NSObject {
    
    static func createRepository(nomeRepositorio: String, username: String) {
        let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Repository", inManagedObjectContext: contexto!)
        let repository = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Repository
        
        var user = self.getCurrentUser(username)

        repository.name = nomeRepositorio
        repository.users = user!
        
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    static func getCurrentUser(username: String) -> User? {
        let contexto = UIApplication.sharedApplication().delegate as! AppDelegate
        var fetchRequest = NSFetchRequest(entityName: "User")
        var err = NSError?()
        
        var users: NSArray! = contexto.managedObjectContext!.executeFetchRequest(fetchRequest, error: &err)
        
        for index in 0...users.count-1 {
            let user = users[index] as! User
            if user.login == username {
                return user
            }
        }
        return nil
    }
    
    static func teste() -> Bool {
        let contexto = UIApplication.sharedApplication().delegate as! AppDelegate
        var fetchRequest = NSFetchRequest(entityName: "User")
        var err = NSError?()
        
        var users: NSArray! = contexto.managedObjectContext!.executeFetchRequest(fetchRequest, error: &err)
        
        if users.count == 1 {
            return true
        }
        return false
    }
}
