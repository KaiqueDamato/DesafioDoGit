//
//  TesteViewController.swift
//  DesafioGit
//
//  Created by Kaique Damato on 4/29/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController {
    
    var gitManager = GitManager.sharedInstance

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func teste() {
        var username = usernameTextField.text
        var password = passwordTextField.text
        
        gitManager.buscaGit(username, password: password) { (success) -> Void in
            if success {
                self.performSegueWithIdentifier("showResults", sender: nil)
            } else {
                let alert = UIAlertController(title: "Usuário inválido", message: "Tente novamente", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
