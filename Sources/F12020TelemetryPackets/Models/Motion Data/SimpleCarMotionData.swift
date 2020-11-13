//
// SimpleCarMotionData.swift
//  
//
//  Created by Erik Hatfield on 7/25/20.
//

import Foundation
import NIO

public struct SimpleCarMotionData: Codable {
    let worldPositionX: Float
    let worldPositionY: Float
    let worldPositionZ: Float
    let index: Int
    
    init?(data: CarMotionData, index: Int) {
        self.worldPositionX = data.worldPositionX
        self.worldPositionY = data.worldPositionY
        self.worldPositionZ = data.worldPositionZ
        self.index = index
    }
}
