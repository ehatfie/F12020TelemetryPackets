//
// SimpleCarMotionData.swift
//  
//
//  Created by Erik Hatfield on 7/25/20.
//

import Foundation
import NIO

public struct SimpleCarMotionData: Codable {
    public let worldPositionX: Float
    public let worldPositionY: Float
    public let worldPositionZ: Float
    public let index: Int
    
    init?(data: CarMotionData, index: Int) {
        self.worldPositionX = data.worldPositionX
        self.worldPositionY = data.worldPositionY
        self.worldPositionZ = data.worldPositionZ
        self.index = index
    }
}
