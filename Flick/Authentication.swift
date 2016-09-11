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
    
    static var deviceID = UUID().uuidString
    
    static var currentUser: User?
    
    static func getLoginUrl(_ withUser: Bool = true) -> URL {
        
        var url: URL
        
        if (withUser) {
            url = URL(string: "https://www.reddit.com/api/v1/authorize?client_id=\(clientID)&response_type=code&state=RANDOM_STRING&redirect_uri=\(redirectURI)&duration=permanent&scope=account,identity,mysubreddits,history,read,save,vote")!
        } else {
            url = URL(string: "https://www.reddit.com/api/v1/access_token")!
        }
        
        return url
    }
    
    static func loginNoUser() {
        Network.requestData(generateRequestNoUser(), callback: assignTokenNoUser)
    }
    
    static func getTokenFromCode(_ code: String) {
        let url = URL(string: "https://www.reddit.com/api/v1/access_token")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "Post"
        request.httpBody = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)".data(using: String.Encoding.utf8)
        let loginString = NSString(format: "%@:%@", clientID, "")
        let loginData: Data = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        print(request)
        Network.requestData(request, callback: getToken)
    }
    
    static func getToken(_ data: Payload) {
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
    
    static func setToken(_ token: String) {
        self.token = token
        getCurrentUser()
    }
    
    private static func getCurrentUser() {
        Network.apiRequest("api/v1/me", callback: updateCurrentUser)
    }
    
    private static func updateCurrentUser(_ data: Payload) {
        currentUser = User(data: data)
        onSuccessfulAuth()
    }
    
    private static func assignTokenNoUser(_ json: Payload) {
        token = json["access_token"] as? String
        print(token!)
    }
    
    private static func generateRequestNoUser() -> NSMutableURLRequest {
        
        let username = clientID
        let password = ""
        
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        let request = NSMutableURLRequest(url: getLoginUrl(false))
        request.httpMethod = "POST"
        let bodyData = "grant_type=https://oauth.reddit.com/grants/installed_client&device_id=\(deviceID)"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
