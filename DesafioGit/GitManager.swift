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
    var notification = NSNotificationCenter.defaultCenter()
    var repository = RepositoriesManager.sharedInstance

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
        var key2 = String()
        
        var dictionary = ((project["parent"] as! NSDictionary)["owner"] as! NSDictionary)
        
        key = dictionary.objectForKey("login") as! String
        key2 = project.objectForKey("name") as! String
        
        if (key == "mackmobile" && repository.verifyData(key2)) {
            RepositoryFactory.createRepository(key2, username: username)
            self.notification.postNotificationName("Pesquisa Terminada", object: self, userInfo: nil)
//            mackmobileProjects.append(project)
            self.searchAllPullRequests(username, password: password, key: key2)
        }
    }
    
    private func searchAllPullRequests(username: String, password: String, key: String) {
        var index = 0
        
        var url = request.getRequest("https://api.github.com/repos/mackmobile/\(key)/pulls?page=1&per_page=100", username: username, password: password)
        
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            var error = NSError?()
            
            if response != nil {
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    var data = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! [NSDictionary]
                    var number = self.searchForNumberProjects(username, projects: data)
                    var labels = self.getLabelsFromPullRequest(username, password: password, project: key, number: number)
                }
            }
        }
    }
    
    private func searchForNumberProjects(username: String, projects: [NSDictionary]) -> NSNumber {
        var index = 0
        var number = NSNumber()
        
        for index; index < projects.count; index++ {
            var pullName = projects[index].objectForKey("user")?.objectForKey("login") as! String
            
            if pullName == username {
                number = projects[index].objectForKey("number") as! NSNumber
            }
        }
        return number
    }
    
    private func getLabelsFromPullRequest(username: String, password: String, project: String, number: NSNumber) -> [String] {
        var labels = [NSDictionary]()
        var code = number.integerValue
        var url = request.getRequest("https://api.github.com/repos/mackmobile/\(project)/issues/\(code)", username: username, password: password)
        
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            var error = NSError?()
            
            if response != nil {
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    var data = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
                    labels = data.objectForKey("labels") as! [NSDictionary]
                    println(labels)
                }
            }
        }
        return [String]()
    }
}
