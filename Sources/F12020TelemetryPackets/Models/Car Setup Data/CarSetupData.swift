//
//  CarSetupData.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct CarSetupData {
    public let frontWing: Int  // uint8.self
    public let rearWing: Int  // uint8.self
    
    public let onThrottle: Int  // uint8.self, Diff adjustment on throttle %
    public let offThrottle: Int  // uint8.self, Diff adjustment off throttle %
    
    public let frontCamber: Float  // front camber angle
    public let rearCamber: Float  // rear camber angle
    
    public let frontToe: Float
    public let rearToe: Float
    
    public let frontSuspension: Int  // uint8.self
    public let rearRuspension: Int  // uint8.self
    
    public let frontAntiRollBar: Int  // uint8.self
    public let rearAntiRollBar: Int  // uint8.self
    
    public let frontSuspensionHeight: Int  // uint8.self
    public let rearSuspensionHeight: Int  // uint8.self
    
    public let brakePressure: Int  // uint8.self, percentage
    public let brakeBias: Int  // uint8.self, percentage
    
    public let frontLeftTirePressure: Float  // PSI
    public let frontRightTirePressure: Float  // PSI
    
    public let rearLeftTirePressure: Float  // PSI
    public let rearRightTirePressure: Float  // PSI
    
    public let ballast: Int  // uint8.self
    public let fuelLoad: Float
    
    public init?(data: inout ByteBuffer) {
        guard let frontWing = data.readInt(as: UInt8.self),
              let rearWing = data.readInt(as: UInt8.self),
              let onThrottle = data.readInt(as: UInt8.self),
              let offThrottle = data.readInt(as: UInt8.self),
              let frontCamber = data.readFloat(),
              let rearCamber = data.readFloat(),
              let frontToe = data.readFloat(),
              let rearToe = data.readFloat(),
              let frontSuspension = data.readInt(as: UInt8.self),
              let rearSuspension = data.readInt(as: UInt8.self),
              let frontAntiRollbar = data.readInt(as: UInt8.self),
              let rearAntiRollbar = data.readInt(as: UInt8.self),
              let frontSuspensionHeight = data.readInt(as: UInt8.self),
              let rearSuspensionHeight = data.readInt(as: UInt8.self),
              let brakePressure = data.readInt(as: UInt8.self),
              let brakeBias = data.readInt(as: UInt8.self),
              let frontLeftTirePressure = data.readFloat(),
              let frontRightTirePressure = data.readFloat(),
              let rearLeftTirePressure = data.readFloat(),
              let rearRightTirePressure = data.readFloat(),
              let ballast = data.readInt(as: UInt8.self),
              let fuelLoad = data.readFloat()
        else {
            return nil
        }
              
        self.frontWing = frontWing
        self.rearWing = rearWing
        
        self.onThrottle = onThrottle
        self.offThrottle = offThrottle
        
        self.frontCamber = frontCamber
        self.rearCamber = rearCamber
        
        self.frontToe = frontToe
        self.rearToe = rearToe
        
        self.frontSuspension = frontSuspension
        self.rearRuspension = rearSuspension
        
        self.frontAntiRollBar = frontAntiRollbar
        self.rearAntiRollBar = rearAntiRollbar
        
        self.frontSuspensionHeight = frontSuspensionHeight
        self.rearSuspensionHeight = rearSuspensionHeight
        
        self.brakePressure = brakePressure
        self.brakeBias = brakeBias
        
        self.frontLeftTirePressure = frontLeftTirePressure
        self.frontRightTirePressure = frontRightTirePressure
        
        self.rearLeftTirePressure = rearLeftTirePressure
        self.rearRightTirePressure = rearRightTirePressure
        
        self.ballast = ballast
        self.fuelLoad = fuelLoad
    }
}
