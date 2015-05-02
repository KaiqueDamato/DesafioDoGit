//
//  InterfaceController.swift
//  DesafioGit WatchKit Extension
//
//  Created by Cauê Silva on 02/05/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    // MARK: - Outlets and Properties
    //================================================================================
    
    // Outlet tableView
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    // Array teste
    var arrayRepositories = [("Repository A"), ("Repository B"), ("Repository C"),
                             ("Repository D"), ("Repository E"), ("Repository F")]
    //================================================================================
    
    
    
    // MARK: - Interface DidLoad
    //================================================================================
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
    }
    //================================================================================
    
    
    
    // MARK: - Interface WillAppear
    //================================================================================
    override func willActivate()
    {
        super.willActivate()
        
        // Number of rows in tableView
        self.tableView.setNumberOfRows(self.arrayRepositories.count, withRowType: "cell")
        
        // Cell for row
        for (var i=0; i<self.tableView.numberOfRows; i++)
        {
            var titleString: String = self.arrayRepositories[i] as String
            
            var theRow: TextRowType = self.tableView.rowControllerAtIndex(i) as! TextRowType
            
            theRow.rowRepository.setText(titleString)
        }
    }
    //================================================================================
    
    
    
    // MARK: - Interface PrepareForSegue
    //================================================================================
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject?
    {
        return self.arrayRepositories[rowIndex]
    }
    //================================================================================
    
    
    
    // MARK: - Interface didDeactivate
    //================================================================================
    override func didDeactivate()
    {
        super.didDeactivate()
    }
    //================================================================================

}
