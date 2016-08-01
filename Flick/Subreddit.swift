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
    var description: String
    var publicDescription: String
    var ID: String
    var numSubscribers: Int
    var over18: Bool
    
    init(name: String, description: String, publicDescription: String, ID: String, numSubscribers: Int, over18: Bool) {
        self.name = name
        self.description = description
        self.publicDescription = publicDescription
        self.ID = ID
        self.numSubscribers = numSubscribers
        self.over18 = over18
    }
}