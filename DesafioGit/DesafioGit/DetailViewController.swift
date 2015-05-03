//
//  DetailViewController.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: - Properties and Outlets
    //================================================================================
    var repositoryName = ""
    
    @IBOutlet weak var nomeText: UILabel!
    //================================================================================
    
    
    
    // MARK: - VC's Life Cycle
    //================================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = repositoryName
        
        nomeText.text = repositoryName
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //================================================================================

}