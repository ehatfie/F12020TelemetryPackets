//
//  CarMotionPacket.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//
import Foundation
import NIO

public class MotionDataPacketHandler: PacketHandler {
    typealias PacketType = MotionDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}

public struct MotionDataPacket {
    let header: PacketHeader
    var carMotionData: [CarMotionData]
    
    /*
     TODO:
     suspensionPosition RL, RR, FL, FR
     suspensionVelocity RL, RR, FL, FR
     suspensionAcceleration RL, RR, FL, FR
     wheelSpeed RL, RR, FL, FR
     wheelSlip RL, RR, FL, FR
     */
    let suspensionPosition: [Float]
    let suspensionVelocity: [Float]
    let suspensionAcceleration: [Float]
    let wheelSpeed: [Float]
    let wheelSlip: [Float]
    // velocities in local space
    let localVelocityX: Float
    let localVelocityY: Float
    let localVelocityZ: Float
    
    let angularVelocityX: Float
    let angularVelocityY: Float
    let angularVelocityZ: Float
    
    let angularAccelerationX: Float
    let angularAccelerationY: Float
    let angularAccelerationZ: Float
    
    // current front wheel angle in raidians
    var frontWheelsAngle: Float
    
    init?(header: PacketHeader, data: inout ByteBuffer) {
        self.header = header
        
        guard let motionData = CarMotionData(data: &data),
              let suspensionPosition = data.readMultipleFloat(count: 4),
              let suspensionVelocity = data.readMultipleFloat(count: 4),
              let suspensionAcceleration = data.readMultipleFloat(count: 4),
              let wheelSpeed = data.readMultipleFloat(count: 4),
              let wheelSlip = data.readMultipleFloat(count: 4),
              let localVelocityX = data.readFloat(),
              let localVelocityY = data.readFloat(),
              let localVelocityZ = data.readFloat(),
              let angularVelocityX = data.readFloat(),
              let angularVelocityY = data.readFloat(),
              let angularVelocityZ = data.readFloat(),
              let angularAccelerationX = data.readFloat(),
              let angularAccelerationY = data.readFloat(),
              let angularAccelerationZ = data.readFloat(),
              let frontWheelsAngle = data.readFloat()
        else { return nil }
        self.carMotionData = [motionData]
        
        self.suspensionPosition = suspensionPosition
        self.suspensionVelocity = suspensionVelocity
        self.suspensionAcceleration = suspensionAcceleration
        self.wheelSpeed = wheelSpeed
        self.wheelSlip = wheelSlip
        
        self.localVelocityX = localVelocityX
        self.localVelocityY = localVelocityY
        self.localVelocityZ = localVelocityZ
        
        self.angularVelocityX = angularVelocityX
        self.angularVelocityY = angularVelocityY
        self.angularVelocityZ = angularVelocityZ
        
        self.angularAccelerationX = angularAccelerationX
        self.angularAccelerationY = angularAccelerationY
        self.angularAccelerationZ = angularAccelerationZ
        
        self.frontWheelsAngle = frontWheelsAngle
    }
}

extension ByteBuffer {
    // rename
    func getTireInfo(data: inout ByteBuffer) -> [Float?] {
        var values = [Float?]()
        for _ in 0..<4 {
            values.append(data.readFloat())
        }
        return values
    }
}
