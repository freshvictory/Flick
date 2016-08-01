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
    
    static func requestData(request: NSURLRequest, callback: (data: Payload) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var json: Payload?
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = session.dataTaskWithRequest(request) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
                    print(json)
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
            } else if let _ = response as? NSHTTPURLResponse {
                
            }
        }
        
        dataTask.resume()
    }
}