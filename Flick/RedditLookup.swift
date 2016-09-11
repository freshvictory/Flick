//
//  RedditLookup.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class RedditLookup {
    
    static func user(_ username: String, callback: (data: Payload) -> Void) {
        Network.apiRequest("user/\(username)/about", callback: callback)
    }

    static func subreddit(_ name: String, callback: (data: Payload) -> Void) {
        Network.apiRequest("r/\(name)/about", callback: callback)
    }
    
    static func posts(_ subreddit: Subreddit, page: Int, callback: (data: Payload) -> Void) {
        Network.apiRequest(subreddit == Subreddit.Front ? "" : "r/\(subreddit.name)/", callback: callback)
    }
}
