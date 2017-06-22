//
//  ModelsAndData.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/18/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Foundation
import SpriteKit

/////////////////////
/////   SIDES   /////
/////////////////////

enum colorType {
    
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case Green
    
}

let colorWheelOrder: [colorType] = [
    
    .Red,
    .Orange,
    .Yellow,
    .Green,
    .Blue,
    .Purple,
    .Pink
    
]

// All balls can be green
let colorWheelOrderEasy: [colorType] = [
    
    .Red,
    .Red,
    .Green,
    .Green,
    .Blue,
    .Blue,
    .Blue
    
]

// All balls can be green, super fast speed
let colorWheelOrderHard: [colorType] = [
    
    .Green,
    .Red,
    .Red,
    .Red,
    .Red,
    .Red,
    .Red
    
]

var sidePositions: [CGPoint] = []


//////////////////////////
/////   GAME STATE   /////
//////////////////////////

enum gameState {
    
    case beforeGame
    case inGame
    case afterGame
    
}

//////////////////////////////////
/////   PHYSICS CATAGORIES   /////
//////////////////////////////////

struct PhysicsCatagories {
    static let None: UInt32 = 0 //0
    static let Ball: UInt32 = 0b1 //1
    static let Side: UInt32 = 0b10 //2
}

////////////////////////////
/////   SCORE SYSTEM   /////
////////////////////////////

var score: Int = 0

////////////////////////////
/////   LEVEL SYSTEM   /////
////////////////////////////

var ballMovementSpeed: TimeInterval = 2








