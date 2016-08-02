//
//  Authentication.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation
import UIKit

class Authentication {
    
    /// Flick's reddit Client ID
    static var clientID: String = "4z9lGA0CVOIG6g"
    
    static var authURL: String = "https://oauth.reddit.com/"
    
    static var loggedIn: Bool = false
    
    static var user: User?
    
    static var token: String?
    
    static var responseText: String = "Something went wrong"
    
    static var deviceID = NSUUID().UUIDString
    
    static func getLoginUrl(withUser: Bool = true) -> NSURL {
        
        var url: NSURL
        
        if (withUser) {
            url = NSURL(string: "https://www.reddit.com/api/v1/authorize?client_id=\(clientID)&response_type=token& state=RANDOM_STRING&redirect_uri=flick://oauth&duration=permanent&scope=account,identity,mysubreddits,history,read,save,vote")!
        } else {
            url = NSURL(string: "https://www.reddit.com/api/v1/access_token")!
        }
        
        return url
    }
    
    static func login(withUser: Bool = true) {
        
        if (withUser) {
            
        } else {
            Network.requestData(generateRequestNoUser(), callback: assignTokenNoUser)
        }
    }
    
    private static func assignTokenNoUser(json: Payload) {
        token = json["access_token"] as? String
        print(token!)
    }
    
    private static func generateRequestNoUser() -> NSMutableURLRequest {
        
        let username = clientID
        let password = ""
        
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0))
        
        let request = NSMutableURLRequest(URL: getLoginUrl(false))
        request.HTTPMethod = "POST"
        let bodyData = "grant_type=https://oauth.reddit.com/grants/installed_client&device_id=\(deviceID)"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}