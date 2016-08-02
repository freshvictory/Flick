//
//  Subreddit.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class Subreddit {
    var name: String
    var title: String
    var description: String
    var publicDescription: String
    var ID: String
    var numSubscribers: Int
    var over18: Bool
    
    init(name: String, title: String, description: String, publicDescription: String, ID: String, numSubscribers: Int, over18: Bool) {
        self.name = name
        self.title = title
        self.description = description
        self.publicDescription = publicDescription
        self.ID = ID
        self.numSubscribers = numSubscribers
        self.over18 = over18
    }
    
    convenience init(name: String) {
        self.init(name: name, title: "", description: "", publicDescription: "", ID: "", numSubscribers: 0, over18: false)
        RedditLookup.subreddit(name, callback: self.updateFromJSON)
    }
    
    private func updateFromJSON(data: Payload) {
        guard let sdata = data["data"] as? Payload, let t = sdata["title"] as? String, let desc = sdata["description"] as? String, let publicDesc = sdata["public_description"] as? String, let id = sdata["name"] as? String, let numSub = sdata["subscribers"] as? Int, let over = sdata["over18"] as? Int
            else {
                return
        }
        
        title = t
        description = desc
        publicDescription = publicDesc
        ID = id
        numSubscribers = numSub
        over18 = over == 1
    }
}