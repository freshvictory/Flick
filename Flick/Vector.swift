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
    
    static func direction(point: CGPoint) -> Direction {
        if (horizontal(point)) {
            return point.x < 0 ? Direction.Left : Direction.Right
        } else {
            return point.y < 0 ? Direction.Down : Direction.Up
        }
    }
    
    static func vertical(point: CGPoint) -> Bool {
        return (abs(point.y / point.x) > 1)
    }
    
    static func horizontal(point: CGPoint) -> Bool {
        return !vertical(point)
    }
}

enum Direction {
    case Up
    case Down
    case Left
    case Right
}