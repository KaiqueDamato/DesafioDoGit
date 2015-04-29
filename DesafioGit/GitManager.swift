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

    private init(){}
    
    func buscaGit(username: String, password: String, completion: (success: Bool) -> Void) {
        var url =  request.getRequest("https://api.github.com/users/KaiqueDamato/repos", username: username, password: password)
        
        NSURLConnection.sendAsynchronousRequest(url, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            var error = NSError?()
            if response != nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                println("Response: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 {
                    let dataArr = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! [NSDictionary]
                    completion(success: true)
                        println(dataArr)
                } else {
                    completion(success: false)
                }
            }
        }
    }
}
