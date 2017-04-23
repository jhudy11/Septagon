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
    
    init() {
        
        let randomTypeIndex = Int(arc4random() % 7)
        self.type = colorWheelOrder[randomTypeIndex]
        
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
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
    
}



















