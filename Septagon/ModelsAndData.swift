//
//  ModelsAndData.swift
//  Septagon
//
//  Created by Joshua Hudson on 4/18/17.
//  Copyright © 2017 ParanoidPenguinProductions. All rights reserved.
//

import Foundation

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





