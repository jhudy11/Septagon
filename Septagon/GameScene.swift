//
//  GameScene.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/17/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var colorWheelBase = SKShapeNode()
    
    // Input is in radians, thus the helper function to convert from degrees to radians
    // The negative allows for a clockwise rotation
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360 / 7), duration: 0.2)
    
    var currentGameState: gameState = gameState.beforeGame
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        self.addChild(background)
        
        colorWheelBase = SKShapeNode(rectOf: CGSize(width: self.size.width * 0.8, height: self.size.width * 0.8))
        colorWheelBase.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        colorWheelBase.fillColor = SKColor.clear
        colorWheelBase.strokeColor = SKColor.clear
        self.addChild(colorWheelBase)
        
        prepColorWheel()
        
        tapToStartLabel.text = "Tap To Start"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 10)
        self.addChild(tapToStartLabel)
        
    }
    
    func prepColorWheel() {
        
        for i in 0...6 {
            
            let side = Side(type: colorWheelOrder[i])
            let basePosition = CGPoint(x: self.size.width / 2, y: self.size.height / 4)
            side.position = convert(basePosition, to: colorWheelBase)
            side.zRotation = -colorWheelBase.zRotation
            colorWheelBase.addChild(side)
            
            // Complete circle of 360 / 7 sides
            colorWheelBase.zRotation += convertDegreesToRadians(degrees: 360/7)
            
        }
        
        // Get the starting positions of the sides
        for side in colorWheelBase.children {
            
            let sidePosition = side.position
            let positionInScene = convert(sidePosition, from: colorWheelBase)
            sidePositions.append(positionInScene)
            
        }
        
    }
    
    // Add a ball in the center of the screen
    func spawnBall() {
        
        let ball = Ball()
        ball.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(ball)
        
    }
    
    func startTheGame() {
        
        spawnBall()
        
        currentGameState = .inGame
        
        scaleDownAndRemoveStartLabel()
        
    }
    
    func scaleDownAndRemoveStartLabel() {
        
        // Scale the label before removing it from scene
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .beforeGame {
            
            // Start the Game
            startTheGame()
            
        }
        
        else if currentGameState == .inGame {
            
            // Spin the colorwheel
            colorWheelBase.run(spinColorWheel)
            
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let ball: Ball
        let side: Side
        
        if contact.bodyA.categoryBitMask == PhysicsCatagories.Ball {
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
        } else {
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        
        if ball.isActive == true {
            checkMatch(ball: ball, side: side)
            ball.delete()
            spawnBall()
        }
        
    }
    
    func checkMatch(ball: Ball, side: Side) {
        
        if ball.type == side.type {
            // Correct Match
            print("Correct!")
        } else {
            // Incorrect Match
            print("Incorrect")
        }
        
    }
    
}























