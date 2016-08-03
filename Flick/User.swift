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
    var over18: Bool = false
    
    var loading: Bool = false
    
    init(username: String, linkKarma: Int, commentKarma: Int, over18: Bool = false) {
        self.username = username
        self.linkKarma = linkKarma
        self.commentKarma = commentKarma
        self.over18 = over18
    }
    
    convenience init (username: String) {
        self.init(username: username, linkKarma: 0, commentKarma: 0)
        Refresh()
    }
    
    convenience init(data: Payload) {
        guard let name = data["name"] as? String, let comment = data["comment_karma"] as? Int, let link = data["link_karma"] as? Int, let o18 = data["over_18"] as? Int
            else {
            self.init(username: "", linkKarma: 0, commentKarma: 0)
            return
        }
        self.init(username: name, linkKarma: link, commentKarma: comment, over18: o18 == 1)
    }
    
    func Refresh() {
        loading = true
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
        
        loading = false
    }
}