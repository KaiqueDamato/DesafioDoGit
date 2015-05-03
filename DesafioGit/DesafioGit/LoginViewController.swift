//
//  TesteViewController.swift
//  DesafioGit
//
//  Created by Kaique Damato on 4/29/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController {
    
    
    // MARK: - Properties and Outlets
    //================================================================================
    
    // Singleton - gitManager
    var gitManager = GitManager.sharedInstance

    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //================================================================================
    
    
    
    // MARK: - VC's Life Cycle
    //================================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //================================================================================
    
    
    
    // MARK: - Button "Entrar"
    //================================================================================
    @IBAction func submit()
    {
        var username = usernameTextField.text
        var password = passwordTextField.text
        
        gitManager.gitSearchForRepos(username, password: password) { (success) -> Void in
            
            if success
            {
                self.performSegueWithIdentifier("showResults", sender: nil)
            }
            else
            {
                let alert = UIAlertController(
                    title: "Login inválido",
                    message: "Username ou password incorretos",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(
                    title: "Ok",
                    style: UIAlertActionStyle.Default,
                    handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    //================================================================================

}
