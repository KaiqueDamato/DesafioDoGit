//
//  RequestAuthorization.swift
//  DesafioGit
//
//  Created by Kaique Damato on 4/29/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class RequestAuthorization: NSObject {
    
    func getRequest(url: String, username: String, password: String) -> NSMutableURLRequest {
        let login = String(format: "\(username):\(password)")
        let loginData = login.dataUsingEncoding(NSUTF8StringEncoding)
        let baseLogin = loginData!.base64EncodedStringWithOptions(nil)
        
        let url2 = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url2!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(baseLogin)", forHTTPHeaderField: "Authorization")
        return request
    }
   
}
