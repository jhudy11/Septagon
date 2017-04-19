//
//  GameScene.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/17/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var colorWheelBase = SKShapeNode()
    
    // Input is in radians, thus the helper function to convert from degrees to radians
    // The negative allows for a clockwise rotation
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360 / 7), duration: 0.2)
    
    override func didMove(to view: SKView) {
        
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        colorWheelBase.run(spinColorWheel)
        
    }
    
}























