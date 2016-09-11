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
    
    static func requestData(request: URLRequest, callback: (data: Payload) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
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
            } else if let _ = response as? HTTPURLResponse {
                
            }
        }
        
        dataTask.resume()
    }
    
    static func requestData(urlString: String, callback: (data: Payload) -> Void) {
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
        print(request)
        requestData(request, callback: callback)
    }
}
