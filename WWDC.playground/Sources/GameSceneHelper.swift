//
//  GameSceneHelper.swift
//  SimpleSpriteKitExample
//
//  Created by Mariela Andrade on 30/03/17.
//  Copyright © 2017 Mariela Andrade. All rights reserved.
//
import UIKit
import PlaygroundSupport
import SpriteKit



// Helping functions for game


// CGPoint Operators
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    public func normalized() -> CGPoint {
        return self / length()
    }
}

// Random functions for characters positions
public func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

public func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

// Physics colision map struct
public struct PhysicsCategory {
    public static let None      : UInt32 = 0
    public static let All       : UInt32 = UInt32.max
    public static let Trash   : UInt32 = 0b1       // 1
    public static let Bin: UInt32 = 0b10      // 2
}


