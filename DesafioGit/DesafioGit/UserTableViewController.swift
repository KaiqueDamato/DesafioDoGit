//
//  UserTableViewController.swift
//  DesafioGit
//
//  Created by Rafael Souza Belchior da Silva on 29/04/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController, UITableViewDataSource {
    lazy var users:Array<User> = {
        return UsersManager.sharedInstance.findUsers()
        }()
    var gitManager = GitManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        users = UsersManager.sharedInstance.findUsers()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let user:User = users[indexPath.row]
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("userCell") as! UITableViewCell

        cell.textLabel?.text = user.login
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let follow = segue.destinationViewController as? RepositoryTableViewController {
            follow.user = users[tableView.indexPathForSelectedRow()!.row]
        }
    }
}
