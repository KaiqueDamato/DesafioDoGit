//
//  DetailInterfaceController.swift
//  DesafioGit
//
//  Created by Cauê Silva on 02/05/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    // MARK: - Outlets and Properties
    //================================================================================
    // Outlets Labels
    @IBOutlet weak var lblRepository: WKInterfaceLabel!
    @IBOutlet weak var lblDetail: WKInterfaceLabel!
    //================================================================================
    
    
    
    // MARK: - Interface DidLoad
    //================================================================================
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context) // context of previous interface
        
        var titleString: String = context as! String
        
        self.lblRepository.setText(titleString)
        self.lblDetail.setText("Detail \(titleString)")
    }
    //================================================================================
    
    
    
    // MARK: - Interface WillAppear
    //================================================================================
    override func willActivate()
    {
        super.willActivate()
    }
    //================================================================================
    
    
    
    // MARK: - Interface DidDeactive
    //================================================================================
    override func didDeactivate()
    {
        super.didDeactivate()
    }
    //================================================================================

}
