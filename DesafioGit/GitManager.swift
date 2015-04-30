//
//  GitManager.swift
//  DesafioGit
//
//  Created by Kaique Damato on 4/29/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

public class GitManager {
    static let sharedInstance:GitManager = GitManager()
    let request = RequestAuthorization()
    var mackmobileProjects = [NSDictionary]()

    private init(){}
    
    func gitSearchForRepos(username: String, password: String, completion: (success: Bool) -> Void) {
        var url =  request.getRequest("https://api.github.com/users/\(username)/repos", username: username, password: password)
        
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            var error = NSError?()
            
            if response != nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    var data = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! [NSDictionary]
                    completion(success: true)
                    
                    var names = self.serachForNameProjects(data)
                    self.gitSearchForMackMobilePullRequests(username, password: password, projectNames: names)
                }
            } else {
                completion(success: false)
            }
        }
    }
    
    private func serachForNameProjects(projects: [NSDictionary]) -> [String] {
        var index = 0
        var project = [String]()
        
        for index; index < projects.count; index++ {
            project.append(projects[index].objectForKey("name") as! String)
        }
        return project
    }
    
    private func gitSearchForMackMobilePullRequests(username: String, password: String, projectNames: [String]) {
        var index = 0
        var searchResult = NSDictionary()
        
        for index; index < projectNames.count; index++ {
            var url = request.getRequest("https://api.github.com/repos/\(username)/\(projectNames[index])", username: username, password: password)
            
            NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                var error = NSError?()
                
                if response != nil {
                    
                    let httpResponse = response as! NSHTTPURLResponse
                    
                    if httpResponse.statusCode == 200 {
                        searchResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
                        var searchResultTest: NSDictionary? = searchResult.objectForKey("parent") as? NSDictionary
                        
                        if (searchResultTest?.count != nil) {
                           self.getParentDictionary(searchResult)
                        }
                    }
                }
            })
        }
    }
    
    private func getParentDictionary(project: NSDictionary) {
        var index = 0
        var key = String()
        
        var dictionary = ((project["parent"] as! NSDictionary)["owner"] as! NSDictionary)
        
        key = dictionary.objectForKey("login") as! String
        
        if (key == "mackmobile") {
            mackmobileProjects.append(project)
        }
    }
}
