//
//  Label.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import Foundation
import CoreData

@objc(Label)
class Label: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var repository: Repository
    
}