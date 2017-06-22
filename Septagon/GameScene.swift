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
    let playCorrectSound = SKAction.playSoundFileNamed("correctSound.wav", waitForCompletion: false)
    let playIncorrectSound = SKAction.playSoundFileNamed("incorrectSound.wav", waitForCompletion: false)
    
    var currentGameState: gameState = gameState.beforeGame
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    let scoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    let highScoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
    
    override func didMove(to view: SKView) {
        
        score = 0
        ballMovementSpeed = 2
        
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
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 225
        scoreLabel.fontColor = SKColor.darkGray
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.85)
        self.addChild(scoreLabel)
        
        highScoreLabel.text = "Best: \(highScore)"
        highScoreLabel.fontSize = 100
        highScoreLabel.fontColor = SKColor.darkGray
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
        self.addChild(highScoreLabel)
        
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
        }
        
    }
    
    func checkMatch(ball: Ball, side: Side) {
        
        if ball.type == side.type {
            // Correct Match
            print("Correct!")
            correctMatch(ball: ball)
            
        } else {
            // Incorrect Match
            print("Incorrect")
            wrongMatch(ball: ball)
        }
        
    }
    
    func correctMatch(ball: Ball) {
        ball.delete()
        
        score += 1
        scoreLabel.text = "\(score)"
        
        // Difficulty System
        switch score {
        case 5:
            ballMovementSpeed = 1.8
        case 15:
            ballMovementSpeed = 1.6
        case 25:
            ballMovementSpeed = 1.5
        case 40:
            ballMovementSpeed = 1.4
        case 60:
            ballMovementSpeed = 1.3
        default:
            print("No level change")
        }
        
        spawnBall()
        
        if score > highScore {
            highScoreLabel.text = "Best: \(score)"
        }
        
        self.run(playCorrectSound)
        
    }
    
    func wrongMatch(ball: Ball) {
        // End the game
        
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
        
        ball.flash()
        self.run(playIncorrectSound)
        currentGameState = .afterGame
        
        colorWheelBase.removeAllActions()
        
        let waitToChangeScene = SKAction.wait(forDuration: 3)
        let changeScene = SKAction.run {
            let sceneToMoveTo = GameOverScene(fileNamed: "GameOverScene")!
            //let sceneToMoveTo = SKScene(fileNamed: "GameOverScene")!
            
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        }
        
        let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
        self.run(sceneChangeSequence)
        
    }
    
}























