//
//  CarMotionData.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Foundation
import NIO

public struct CarMotionData: Codable {
    public let worldPositionX: Float
    public let worldPositionY: Float
    public let worldPositionZ: Float
    
    public let worldVelocityX: Float
    public let worldVelocityY: Float
    public let worldVelocityZ: Float
    
    public let worldForwardDirX: Int   // Int16
    public let worldForwardDirY: Int   // Int16
    public let worldForwardDirZ: Int   // Int16
    
    public let worldRightDirX: Int     // Int16
    public let worldRightDirY: Int     // Int16
    public let worldRightDirZ: Int     // Int16
    
    public let gForceLateral: Float
    public let gForceLongitudinal: Float
    public let gForceVertical: Float
    
    public let yaw: Float
    public let pitch: Float
    public let roll: Float
    
    init?(data: inout ByteBuffer) {
        guard let worldPositionX = data.readFloat(),
              let worldPositionY = data.readFloat(),
              let worldPositionZ = data.readFloat(),
              let worldVelocityX = data.readFloat(),
              let worldVelocityY = data.readFloat(),
              let worldVelocityZ = data.readFloat(),
              let worldForwardDirX = data.readInt(as: Int16.self),
              let worldForwardDirY = data.readInt(as: Int16.self),
              let worldForwardDirZ = data.readInt(as: Int16.self),
              let worldRightDirX = data.readInt(as: Int16.self),
              let worldRightDirY = data.readInt(as: Int16.self),
              let worldRightDirZ = data.readInt(as: Int16.self),
              let gForceLateral = data.readFloat(),
              let gForceLongitudinal = data.readFloat(),
              let gForceVertical = data.readFloat(),
              let yaw = data.readFloat(),
              let pitch = data.readFloat(),
              let roll = data.readFloat()
        else {
            return nil
        }
        
        self.worldPositionX = worldPositionX
        self.worldPositionY = worldPositionY
        self.worldPositionZ = worldPositionZ
        
        self.worldVelocityX = worldVelocityX
        self.worldVelocityY = worldVelocityY
        self.worldVelocityZ = worldVelocityZ
        
        self.worldForwardDirX = worldForwardDirX
        self.worldForwardDirY = worldForwardDirY
        self.worldForwardDirZ = worldForwardDirZ
        
        self.worldRightDirX = worldRightDirX
        self.worldRightDirY = worldRightDirY
        self.worldRightDirZ = worldRightDirZ
        
        self.gForceLateral = gForceLateral
        self.gForceLongitudinal = gForceLongitudinal
        self.gForceVertical = gForceVertical
        
        self.yaw = yaw
        self.pitch = pitch
        self.roll = roll
    }
}
