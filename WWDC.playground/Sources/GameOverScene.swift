//
//  GameOverScene.swift
//  SimpleSpriteKitExample
//
//  Created by Mariela Andrade on 30/03/17.
//  Copyright © 2017 Mariela Andrade. All rights reserved.
//

import Foundation
import SpriteKit

public class GameOverScene: SKScene {

    public init(size: CGSize, won:Bool) {
      
        super.init(size: size)
        
        if won == true {


        }
        
        else {
            
            let gameoverLabel = SKSpriteNode(imageNamed: "GameOver1")
            gameoverLabel.position = CGPoint(x:size.width/2, y:size.height/2)
            gameoverLabel.scale(to: CGSize(width: frame.width, height: 332))
            
            addChild(gameoverLabel)
    
        }
      
        

        // 4
        run(SKAction.sequence([SKAction.wait(forDuration: 3.0),SKAction.run() {
                // 5
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }]))
        
    }
    
    // 6
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
