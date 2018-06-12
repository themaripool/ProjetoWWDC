//
//  GameViewController.swift
//  SimpleSpriteKitExample
//
//  Created by Mariela Andrade on 30/03/17.
//  Copyright © 2017 Mariela Andrade. All rights reserved.
//

import UIKit
import PlaygroundSupport
import SpriteKit

public class GameViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override public var prefersStatusBarHidden : Bool {
        return true
    }
}
