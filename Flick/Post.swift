//
//  Post.swift
//  Flick
//
//  Created by Justin Renjilian on 7/31/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class Post {
    
    /// The title of the `Post`
    var title: String
    
    /// The `User` who submitted the `Post`
    var author: User
    
    /// The score of the `Post`
    var score: Int
    
    /// How many comments the `Post` has
    var numComments: Int
    
    /// The `Subreddit` this `Post` was submitted to
    var subreddit: Subreddit
    
    /// How many times this `Post` has been gilded
    var gilded: Int
    
    /// Has the `Post` been archived
    var archived: Bool
    
    /// Has the `User` already clicked this `Post`
    var clicked: Bool
    
    /// Is this `Post` NSFW
    var over18: Bool
    
    /// Should the `score` be hidden
    var hideScore: Bool
    
    /// Has the `User` hidden this `Post`
    var hidden: Bool
    
    /// Has this `Post` been edited
    var edited: Bool
    
    /// Has the `User` saved this `Post`
    var saved: Bool
    
    /// Is this `Post` stickied
    var stickied: Bool
    
    /// The link to the comments section of this `Post`
    var permaLink: String
    
    /// The time this `Post` was created
    var dateCreated: NSDate
    
    init(title: String, author: User, score: Int, numComments: Int, subreddit: Subreddit, gilded: Int, archived: Bool, clicked: Bool, over18: Bool, hideScore: Bool, hidden: Bool, edited: Bool, saved: Bool, stickied: Bool, permaLink: String, dateCreated: NSDate) {
        self.title = title
        self.author = author
        self.score = score
        self.numComments = numComments
        self.subreddit = subreddit
        self.gilded = gilded
        self.archived = archived
        self.clicked = clicked
        self.over18 = over18
        self.hideScore = hideScore
        self.hidden = hidden
        self.edited = edited
        self.saved = saved
        self.stickied = stickied
        self.permaLink = permaLink
        self.dateCreated = dateCreated
    }
    
    convenience init(postdata: Payload) {
        guard let t = postdata["title"] as? String, let op = postdata["author"] as? String, let votes = postdata["score"] as? Int, let comments = postdata["num_comments"] as? Int, let subredditName = postdata["subreddit"] as? String, let g = postdata["gilded"] as? Int, let arch = postdata["archived"] as? Bool, let cl = postdata["clicked"] as? Bool, let o18 = postdata["over_18"] as? Bool, let hS = postdata["hide_score"] as? Bool, let hide = postdata["hidden"] as? Bool, let ed = postdata["edited"] as? Bool, let st = postdata["stickied"] as? Bool, let pLink = postdata["permalink"] as? String, let s = postdata["saved"] as? Bool
            else {
                print("building post failed")
                self.init(title: "", author: User(username: "", linkKarma: 0, commentKarma: 0), score: 0, numComments: 0, subreddit: Subreddit(name: ""), gilded: 0, archived: false, clicked: false, over18: false, hideScore: false, hidden: false, edited: false, saved: false, stickied: false, permaLink: "", dateCreated: NSDate.distantFuture())
                return
        }
        
        self.init(title: t, author: User(username: op), score: votes, numComments: comments, subreddit: Subreddit(name: subredditName), gilded: g, archived: arch, clicked: cl, over18: o18, hideScore: hS, hidden: hide, edited: ed, saved: s, stickied: st, permaLink: pLink, dateCreated: NSDate.distantFuture())
    }
}