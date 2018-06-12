import SpriteKit
import PlaygroundSupport

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
   
    public var bin = SKSpriteNode()
    
    public var fase: Int = 1
    public let fase2label = SKSpriteNode(imageNamed: "LEVEL02")
    public let fase3label = SKSpriteNode(imageNamed: "LEVEL03")
    public let fase4label = SKSpriteNode(imageNamed: "LEVEL04")
    
    public var scoreLabel: SKLabelNode!
    public var lifeLabel: SKLabelNode!
    
    var score: Int = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var  lives: Int = 3 {
        didSet{
            lifeLabel.text = "Lives: \(lives)"
        }
    }

    
    override public func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
 
        createSceneContents()
        

    }
    
    
   public func createSceneContents(){
        
        removeAllChildren()
        
        
        
       
        let background = SKSpriteNode(imageNamed: "bg2")
        background.zPosition = -0.2
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        addChild(background)
        
        if fase == 1{
            
            bin = SKSpriteNode(imageNamed: "bin1")
            bin.name = "1"
        } else if fase == 2 {
            bin = SKSpriteNode(imageNamed: "bin2")
            bin.name = "2"
        } else if fase == 3 {
            bin = SKSpriteNode(imageNamed: "bin4")
            bin.name = "3"
        } else if fase == 4 {
            bin = SKSpriteNode(imageNamed: "bin3")
            bin.name = "4"
        }
        
        
        
        bin.position = CGPoint(x: self.size.width/2, y: self.size.height/6)
        
        _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(GameScene.addTrash), userInfo: nil, repeats: true)
        
        
        bin.physicsBody = SKPhysicsBody(rectangleOf: bin.size)
        bin.physicsBody?.affectedByGravity = false
        bin.physicsBody?.categoryBitMask = PhysicsCategory.Bin
        bin.physicsBody?.contactTestBitMask = PhysicsCategory.Trash
        bin.physicsBody?.collisionBitMask = PhysicsCategory.None
        bin.physicsBody?.isDynamic = true
        
        addChild(bin)
        
        
        setLives()
        setScore()
        
        
        
    }
    

    //MOVIMENTAÇAO DA LIXEIRA
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
            let location = touch.location(in: view)
            bin.position.x = location.x
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let location = touch.location(in: view)
            bin.position.x = location.x
        }
    }
    
    
   public func setScore() {
        scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        
        scoreLabel.text = "Score = 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 35, y: 550)
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.white
        addChild(scoreLabel)
    }
    
    public func setLives(){
        
        lifeLabel = SKLabelNode(fontNamed: "AmericanTypewriter")
        lifeLabel.text = "Lifes = 3 "
        lifeLabel.horizontalAlignmentMode = .right
        lifeLabel.position = CGPoint(x: 350 , y: 550)
        lifeLabel.fontSize = 30
        lifeLabel.color = UIColor.white
        addChild(lifeLabel)
   
    }
    
    
    // LIXO
    
    public func addTrash() {
        
        var trash = SKSpriteNode()
        
       
        let number = CGFloat(arc4random_uniform(6)+1)
        
        if number == 1{
            
            trash = SKSpriteNode(imageNamed: "paper")
            trash.name = "1"
            
        }
        
        else if number == 2 {
            
            trash = SKSpriteNode(imageNamed: "glass")
            trash.name = "2"
            
        } else if number == 3 {
            
            trash = SKSpriteNode(imageNamed: "organic1")
            
        } else if number == 4 {
            
            trash = SKSpriteNode(imageNamed: "organic2")
            
        } else if number == 5 {
            
            trash = SKSpriteNode(imageNamed: "metal1")
            trash.name = "4"
            
        } else if number == 6 {
            
            trash = SKSpriteNode(imageNamed: "plastic1")
            trash.name = "3"
        }
        
    
        var MinValue = self.size.width/8
        var MaxValue = self.size.width - 20
        var SpawnPoint =  UInt32(MaxValue - MinValue)
        trash.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        addChild(trash)
        
       
        let action = SKAction.moveTo(y: -70, duration: 3.0)
        let actionDone = SKAction.removeFromParent()
        trash.run(SKAction.sequence([action, actionDone]))
       
        trash.physicsBody = SKPhysicsBody(rectangleOf: trash.size)
        trash.physicsBody?.isDynamic = true
        trash.physicsBody?.usesPreciseCollisionDetection = true
        trash.physicsBody?.categoryBitMask = PhysicsCategory.Trash
        trash.physicsBody?.contactTestBitMask = PhysicsCategory.Bin
        trash.physicsBody?.collisionBitMask = PhysicsCategory.None
        trash.physicsBody?.affectedByGravity = false
        

        
        trash.run(action)
    }

    public func trashDidCollideWithBin(trash:SKSpriteNode, bin:SKSpriteNode) {
        
        if trash.name == bin.name{
            
            score += 10
            run(SKAction.playSoundFileNamed("Acertou2.m4a", waitForCompletion: false))
            
            
            if score == 50 {
                
                fase += 1
                
               if fase == 2 {
                
                     _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(GameScene.addTrash), userInfo: nil, repeats: false)
                
             
                
                    fase2label.position = CGPoint(x:size.width/2, y:size.height/2)
                    fase2label.scale(to: CGSize(width: frame.width, height: 332))
                    _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(getter: GameScene.fase2label), userInfo: nil, repeats: true)
                    addChild(fase2label)

                    lives = 3
                    score = 0
  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        self.createSceneContents(); self.addTrash()
                    })
                
                
               
    
                }
                if fase == 3 {
                    
                    _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(GameScene.addTrash), userInfo: nil, repeats: false)
                    
                    
                    
                    fase3label.position = CGPoint(x:size.width/2, y:size.height/2)
                    fase3label.scale(to: CGSize(width: frame.width, height: 332))
                    _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(getter: GameScene.fase3label), userInfo: nil, repeats: true)
                    addChild(fase3label)
                    
                    lives = 3
                    score = 0
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        self.createSceneContents(); self.addTrash()
                    })
                    
                }
                
                if fase == 4 {
                    
                    _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(GameScene.addTrash), userInfo: nil, repeats: false)
                    
                    
                    
                    fase4label.position = CGPoint(x:size.width/2, y:size.height/2)
                    fase4label.scale(to: CGSize(width: frame.width, height: 332))
                    _ = Timer.scheduledTimer(timeInterval:0.8, target: self, selector: #selector(getter: GameScene.fase4label), userInfo: nil, repeats: true)
                    addChild(fase4label)
                    
                    lives = 3
                    score = 0
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        self.createSceneContents(); self.addTrash()
                    })
                    
                }
 
            }
 
        } else if trash.name != bin.name {
            lives -= 1
             run(SKAction.playSoundFileNamed("errou1.m4a", waitForCompletion: false))
            
            
            
            if (lives < 0){
                
                let reveal = SKTransition.fade(withDuration: 0.5)
                let gameOverScene = GameOverScene(size: self.size, won: false)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }
     
        }
 
        trash.removeFromParent()
    }
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Trash != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Bin != 0)) {
            trashDidCollideWithBin(trash: firstBody.node as! SKSpriteNode, bin: secondBody.node as! SKSpriteNode)
        }
    }
    
}




