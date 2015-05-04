//
//  RepositoriesManager.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import CoreData
import UIKit

public class RepositoriesManager {
    static let sharedInstance:RepositoriesManager = RepositoriesManager()
    static let entityName:String = "Repository"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newRepository()->Repository{
        return NSEntityDescription.insertNewObjectForEntityForName(RepositoriesManager.entityName, inManagedObjectContext: managedContext) as! Repository
    }
    
    func saveRepository(){
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findRepositories()->Array<Repository>{
        let fetchRequest = NSFetchRequest(entityName: RepositoriesManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Repository] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return Array<Repository>()
    }
    
    func verifyData(projectName: String) -> Bool {
        var repositories = self.findRepositories()
        
        for teste in repositories {
            if teste.name == projectName {
                return false
            }
        }
        return true
    }
}
