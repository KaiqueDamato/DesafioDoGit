//
//  LaunchViewController.swift
//  DesafioGit
//
//  Created by Kaique Damato on 5/4/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if RepositoryFactory.teste() {
            sleep(1)
            self.performSegueWithIdentifier("showResults2", sender: nil)
        } else {
            sleep(1)
            self.performSegueWithIdentifier("showLogin", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
