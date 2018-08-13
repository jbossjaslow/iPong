//
//  GameScene.swift
//  iPong
//
//  Created by Josh Jaslow on 2/21/17.
//  Copyright © 2017 Jaslow Enterprises. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    
    var score = [Int]()
    
    var playerScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    override func sceneDidLoad() {
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        player.position.y = (-self.frame.height / 2) + 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        playerScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 8, dy: 8))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 8, dy: 8))
        }
        else{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -8, dy: -8))
        }
        
        playerScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
            
        /*if currentGameType == .twoPlayer {
            if pos.y > 0 {
                enemy.run(SKAction.moveTo(x: pos.x, duration: 0.2))
            }
            if pos.y < 0 {
                player.run(SKAction.moveTo(x: pos.x, duration: 0.2))
            }
        }
        else {
            player.run(SKAction.moveTo(x: pos.x, duration: 0.2)) //gives slight delay to player, can make 0 for perfect feedback
        }*/
        player.run(SKAction.moveTo(x: pos.x, duration: 0.2))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        /*if currentGameType == .twoPlayer {
            if pos.y > 0 {
                enemy.run(SKAction.moveTo(x: pos.x, duration: 0.2))
            }
            if pos.y < 0 {
                player.run(SKAction.moveTo(x: pos.x, duration: 0.2))
            }
        }
        else {
            player.run(SKAction.moveTo(x: pos.x, duration: 0.2)) //gives slight delay to player, can make 0 for perfect feedback
        }*/
        player.run(SKAction.moveTo(x: pos.x, duration: 0.2))
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        /*switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .twoPlayer:
            
            break
        }*/
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
        
        if ball.position.y <= player.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: player)
        }
    }
}
