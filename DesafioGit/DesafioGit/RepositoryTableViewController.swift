//
//  RepositoryTableViewController.swift
//  DesafioGit
//
//  Created by Kaique Damato on 4/30/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class RepositoryTableViewController: UITableViewController, UITableViewDataSource {

    
    // MARK: - Properties
    //================================================================================
    lazy var repositories:Array<Repository> =
    {
        return RepositoriesManager.sharedInstance.findRepositories()
    }()
    //================================================================================
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    // MARK: - VC's Life Cycle
    //================================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: Selector("loaded"), name: "Pesquisa Terminada", object: nil)
    }
    
    func loaded() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationItem.title = "GitHub"
        repositories = RepositoriesManager.sharedInstance.findRepositories()
        self.tableView.reloadData()
    }
    //================================================================================
    
    
    
    // MARK: - TableView Properties
    //================================================================================
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Repositories"
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return repositories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let item:Repository = repositories[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("showDetail", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = item.name

        return cell
    }
    //================================================================================
    
    
    
    // MARK: - Prepare for segue
    //================================================================================
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destino = segue.destinationViewController as? DetailViewController
        {
            destino.repositoryName = repositories[tableView.indexPathForSelectedRow()!.row].name
        }
    }
    //================================================================================
}
