//
//  Vector.swift
//  Flick
//
//  Created by Justin Renjilian on 8/3/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import Foundation
import CoreGraphics

class Vector {
    
    static func direction(_ point: CGPoint) -> Direction {
        if (horizontal(point)) {
            return point.x < 0 ? Direction.left : Direction.right
        } else {
            return point.y < 0 ? Direction.down : Direction.up
        }
    }
    
    static func vertical(_ point: CGPoint) -> Bool {
        return (abs(point.y / point.x) > 1)
    }
    
    static func horizontal(_ point: CGPoint) -> Bool {
        return !vertical(point)
    }
}

enum Direction {
    case up
    case down
    case left
    case right
}
