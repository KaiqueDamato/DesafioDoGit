//
//  UsersManager.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import CoreData
import UIKit

public class UsersManager {
    static let sharedInstance:UsersManager = UsersManager()
    static let entityName:String = "User"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newUser()->User{
        return NSEntityDescription.insertNewObjectForEntityForName(UsersManager.entityName, inManagedObjectContext: managedContext) as! User
    }
    
    func saveUser(){
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findUsers()->Array<User>{
        let fetchRequest = NSFetchRequest(entityName: UsersManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [User] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return Array<User>()
    }
}