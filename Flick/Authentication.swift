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
    
    static var redirectURI: String = "flick://oauth"
    
    static var loggedIn: Bool = false
    
    static var user: User?
    
    static var token: String?
    
    static var refreshToken: String?
    
    static var responseText: String = "Something went wrong"
    
    static var deviceID = NSUUID().UUIDString
    
    static var currentUser: User?
    
    static func getLoginUrl(withUser: Bool = true) -> NSURL {
        
        var url: NSURL
        
        if (withUser) {
            url = NSURL(string: "https://www.reddit.com/api/v1/authorize?client_id=\(clientID)&response_type=code&state=RANDOM_STRING&redirect_uri=\(redirectURI)&duration=permanent&scope=account,identity,mysubreddits,history,read,save,vote")!
        } else {
            url = NSURL(string: "https://www.reddit.com/api/v1/access_token")!
        }
        
        return url
    }
    
    static func loginNoUser() {
        Network.requestData(generateRequestNoUser(), callback: assignTokenNoUser)
    }
    
    static func getTokenFromCode(code: String) {
        let url = NSURL(string: "https://www.reddit.com/api/v1/access_token")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "Post"
        request.HTTPBody = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)".dataUsingEncoding(NSUTF8StringEncoding)
        let loginString = NSString(format: "%@:%@", clientID, "")
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0))
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        print(request)
        Network.requestData(request, callback: getToken)
    }
    
    static func getToken(data: Payload) {
        guard let t = data["access_token"] as? String else {
            return
        }
        setToken(t)
        refreshToken = data["refresh_token"] as? String
        // TODO: refresh timer
    }
    
    static func onSuccessfulAuth() {
        loggedIn = true
        Page.Front = Page(subreddit: Subreddit.Front)
    }
    
    static func setToken(token: String) {
        self.token = token
        getCurrentUser()
    }
    
    private static func getCurrentUser() {
        Network.apiRequest("api/v1/me", callback: updateCurrentUser)
    }
    
    private static func updateCurrentUser(data: Payload) {
        currentUser = User(data: data)
        onSuccessfulAuth()
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