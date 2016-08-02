//
//  User.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class User {
    var username: String
    var linkKarma: Int
    var commentKarma: Int
    
    init(username: String, linkKarma: Int, commentKarma: Int) {
        self.username = username
        self.linkKarma = linkKarma
        self.commentKarma = commentKarma
    }
    
    convenience init (username: String) {
        self.init(username: username, linkKarma: 0, commentKarma: 0)
        RedditLookup.user(username, callback: self.updateFromJSON)
    }
    
    private func updateFromJSON(data: Payload) {
        guard let udata = data["data"] as? Payload, let name = udata["name"] as? String, let link = udata["link_karma"] as? Int, let comment = udata["comment_karma"] as? Int
            else {
                return
        }
        
        username = name
        linkKarma = link
        commentKarma = comment
    }
}