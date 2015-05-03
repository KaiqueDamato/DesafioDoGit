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
    var numbers = [NSNumber]()

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
                            self.getParentDictionary(username, password: password, project: searchResult)
                        }
                    }
                }
            })
        }
    }
    
    private func getParentDictionary(username: String, password: String, project: NSDictionary) {
        var index = 0
        var key = String()
        
        var dictionary = ((project["parent"] as! NSDictionary)["owner"] as! NSDictionary)
        
        key = dictionary.objectForKey("login") as! String
        
        if (key == "mackmobile") {
            key = project.objectForKey("name") as! String
            mackmobileProjects.append(project)
            self.searchAllPullRequests(username, password: password, key: key)
        }
    }
    
    private func searchAllPullRequests(username: String, password: String, key: String) {
        var index = 0
        var searchResult = NSDictionary()
        
        var url = request.getRequest("https://api.github.com/repos/mackmobile/\(key)/pulls?page=1&per_page=100", username: username, password: password)
        
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            var error = NSError?()
            
            if response != nil {
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    var data = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! [NSDictionary]
                    var numbers = self.searchForNumberProjects(username, projects: data)
                }
            }
        }
    }
    
    private func searchForNumberProjects(username: String, projects: [NSDictionary]) -> [NSNumber] {
        var index = 0
        
        for index; index < projects.count; index++ {
            var pullName = projects[index].objectForKey("user")?.objectForKey("login") as! String
            
            if pullName == username {
                numbers.append(projects[index].objectForKey("number") as! NSNumber)
                println(numbers)
            }
        }
        return numbers
    }
}
