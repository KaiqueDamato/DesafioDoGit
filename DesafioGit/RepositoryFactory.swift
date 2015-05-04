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
    
    static func addRepository(nomeRepositorio: String) {
        let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Repository", inManagedObjectContext: contexto!)
        let repository = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Repository
        
        repository.name = nomeRepositorio
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
}
