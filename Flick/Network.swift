//
//  Network.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation
import UIKit

typealias Payload = [String: AnyObject]

class Network {
    
    static var requestsLeft: Int = 60
    
    static var timeLeft: Int = 60
    
    static func requestData(request: NSURLRequest, callback: (data: Payload) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if (requestsLeft == 0) {
            print("Too many requests, sleeping for \(timeLeft)")
            sleep(UInt32(timeLeft))
        }
        
        var json: Payload?
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithRequest(request) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
//                    print(json)
                } catch {
                    print(error)
                }
                
                if let j = json {
                    callback(data: j)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let res = response as? NSHTTPURLResponse {
//                print(res.allHeaderFields)
                if let left = res.allHeaderFields["x-ratelimit-remaining"] as? String {
                    requestsLeft = Int(Double(left)!)
                }
                if let time = res.allHeaderFields["x-ratelimit-reset"] as? String {
                    timeLeft = Int(time)!
                }
//                print("Requests left: \(requestsLeft)")
//                print("Seconds left till refresh: \(timeLeft)")
            }
        }
        
        dataTask.resume()
    }
    
    static func requestData(urlString: String, callback: (data: Payload) -> Void) {
        guard let url = NSURL(string: urlString) else {
            return
        }
        let request = NSURLRequest(URL: url)
        requestData(request, callback: callback)
    }
    
    static func apiRequest(urlString: String, callback: (data: Payload) -> Void) {
        let authURLString = Authentication.authURL + urlString
        guard let url = NSURL(string: authURLString), let token = Authentication.token else {
            print("No auth token or bad api url.")
            return
        }
        let request = NSMutableURLRequest(URL: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        print("Request made to \(request.URL!)")
        requestData(request, callback: callback)
    }
}