//
//  Page.swift
//  Flick
//
//  Created by Justin Renjilian on 8/1/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class Page {
    
    var posts: [Post] = []
    
    var subreddit: Subreddit?
    
    static var Front: Page = Page(subreddit: Subreddit.Front)
    
    init(subreddit: Subreddit) {
        self.subreddit = subreddit
        RedditLookup.posts(subreddit, page: 0, callback: updateFromJSON)
    }
    
    private func updateFromJSON(_ data: Payload) {
        guard let all = data["data"] as? Payload, let children = all["children"] as? [Payload] else {
            return
        }
        
        for post in children {
            guard let postdata = post["data"] as? Payload else {
                continue
            }
            posts.append(Post(postdata: postdata))
        }
    }
}
