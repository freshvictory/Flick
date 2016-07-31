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
}