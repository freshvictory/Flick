//
//  RedditObject.swift
//  Flick
//
//  Created by Justin Renjilian on 8/3/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation

class RedditObject: Equatable {
    var id: String = ""
    var loading: Bool = false
    
    func Refresh() {
        loading = true
    }
    
    func updateFromJSON(_ data: Payload) {
        loading = false
    }
}

func ==(lhs: RedditObject, rhs: RedditObject) -> Bool {
    return lhs.id == rhs.id
}
