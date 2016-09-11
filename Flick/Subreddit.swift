//
//  Subreddit.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class Subreddit: RedditObject {
    var name: String
    var title: String
    var description: String
    var publicDescription: String
    var numSubscribers: Int
    var over18: Bool
    
    static var Front: Subreddit = Subreddit(id: "", name: "", title: "front page", description: "", publicDescription: "", numSubscribers: 0, over18: true)
    
    init(id: String, name: String, title: String, description: String, publicDescription: String,numSubscribers: Int, over18: Bool) {
        self.name = name
        self.title = title
        self.description = description
        self.publicDescription = publicDescription
        self.numSubscribers = numSubscribers
        self.over18 = over18
        
        super.init()
        self.id = id
    }
    
    convenience init(name: String) {
        self.init(id: "", name: name, title: "", description: "", publicDescription: "", numSubscribers: 0, over18: false)
        Refresh()
    }
    
    override func Refresh() {
        loading = true
        RedditLookup.subreddit(name, callback: self.updateFromJSON)
    }
    
    override func updateFromJSON(_ data: Payload) {
        guard let sdata = data["data"] as? Payload, let t = sdata["title"] as? String, let desc = sdata["description"] as? String, let publicDesc = sdata["public_description"] as? String, let name = sdata["name"] as? String, let numSub = sdata["subscribers"] as? Int, let over = sdata["over18"] as? Int
            else {
                return
        }
        
        title = t
        description = desc
        publicDescription = publicDesc
        id = name
        numSubscribers = numSub
        over18 = over == 1
        
        loading = false
    }
}
