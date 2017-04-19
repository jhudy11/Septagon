//
//  SideObject.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/18/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Foundation
import SpriteKit

class Side: SKSpriteNode {
    
    // Create a new property, type, to allow for representation and storage of color property
    let type: colorType
    
    init(type: colorType) {
        self.type = type
        
        let sideTexture = SKTexture(imageNamed: "side_\(self.type)")
        
        super.init(texture: sideTexture, color: SKColor.clear, size: sideTexture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





















