//
//  Label.swift
//  
//
//  Created by Kaique Damato on 5/3/15.
//
//

import Foundation
import CoreData

@objc(Label)
class Label: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var repositories: Repository

}
