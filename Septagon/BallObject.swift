//
//  BallObject.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/22/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    let type: colorType
    var isActive: Bool = true
    
    init() {
        
        let randomTypeIndex = Int(arc4random() % 7)
        self.type = colorWheelOrder[randomTypeIndex]
        
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
        // Collision: two physics bodies will bump each other out of the way
        // Contact: we can run some code when two physics bodies hit
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 55)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = PhysicsCatagories.Ball
        self.physicsBody!.collisionBitMask = PhysicsCatagories.None
        self.physicsBody!.contactTestBitMask = PhysicsCatagories.Side
        
        // Have ball "pop" into the scene
        self.setScale(0)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.2)
        
        // Direct the direction of the ball movement
        let randomSideIndex = Int(arc4random() % 7)
        let sideToMoveTo = sidePositions[randomSideIndex]
        
        let moveToSide = SKAction.move(to: sideToMoveTo, duration: 2)
        
        let ballSpawnSequence = SKAction.sequence([scaleIn, moveToSide])
        
        self.run(ballSpawnSequence)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delete() {
        
        self.isActive = false
        
        // Stops the ball from moving on collision and not having a drift
        // self.removeAllActions()
        
        let scaleDown = SKAction.scale(by: 0, duration: 0.2)
        let deleteBall = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteBall])
        
        self.run(deleteSequence)
        
    }
    
}



















