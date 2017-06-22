//
//  GameOverScene.swift
//  Septagon
//
//  Created by Joshua Hudson on 6/21/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        print("The code is linked up to the SKS file")
        
        let scoreLabel: SKLabelNode = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score: \(score)"
        
        let highScoreLabel: SKLabelNode = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        let highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
        
        highScoreLabel.text = "High Score: \(highScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        
        let sceneTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        
    }
    
}
