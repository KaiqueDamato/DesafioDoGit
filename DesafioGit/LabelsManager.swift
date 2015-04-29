//
//  LabelsManager.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import CoreData
import UIKit

public class LabelsManager {
    static let sharedInstance:LabelsManager = LabelsManager()
    static let entityName:String = "Label"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newLabel()->Label{
        return NSEntityDescription.insertNewObjectForEntityForName(LabelsManager.entityName, inManagedObjectContext: managedContext) as! Label
    }
    
    func saveLabel(){
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findLabels()->Array<Label>{
        let fetchRequest = NSFetchRequest(entityName: LabelsManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Label] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return Array<Label>()
    }
}
