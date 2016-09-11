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
    
    static func requestData(_ request: URLRequest, callback: (data: Payload) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if (requestsLeft == 0) {
            print("Too many requests, sleeping for \(timeLeft)")
            sleep(UInt32(timeLeft))
        }
        
        var json: Payload?
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) {
            data, response, error in
            DispatchQueue.main.async {
                do {
                    json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Payload
//                    print(json)
                } catch {
                    print(error)
                }
                
                if let j = json {
                    callback(data: j)
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let res = response as? HTTPURLResponse {
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
    
    static func requestData(_ urlString: String, callback: (data: Payload) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        requestData(request, callback: callback)
    }
    
    static func apiRequest(_ urlString: String, callback: (data: Payload) -> Void) {
        let authURLString = Authentication.authURL + urlString
        guard let url = URL(string: authURLString), let token = Authentication.token else {
            print("No auth token or bad api url.")
            return
        }
        let request = NSMutableURLRequest(url: url)
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        print("Request made to \(request.url!)")
        requestData(request, callback: callback)
    }
}
