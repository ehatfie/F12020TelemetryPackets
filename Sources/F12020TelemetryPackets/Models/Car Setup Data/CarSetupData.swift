//
//  CarSetupData.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct CarSetupData {
    let frontWing: Int  // uint8.self
    let rearWing: Int  // uint8.self
    
    let onThrottle: Int  // uint8.self, Diff adjustment on throttle %
    let offThrottle: Int  // uint8.self, Diff adjustment off throttle %
    
    let frontCamber: Float  // front camber angle
    let rearCamber: Float  // rear camber angle
    
    let frontToe: Float
    let rearToe: Float
    
    let frontSuspension: Int  // uint8.self
    let rearRuspension: Int  // uint8.self
    
    let frontAntiRollBar: Int  // uint8.self
    let rearAntiRollBar: Int  // uint8.self
    
    let frontSuspensionHeight: Int  // uint8.self
    let rearSuspensionHeight: Int  // uint8.self
    
    let brakePressure: Int  // uint8.self, percentage
    let brakeBias: Int  // uint8.self, percentage
    
    let frontLeftTirePressure: Float  // PSI
    let frontRightTirePressure: Float  // PSI
    
    let rearLeftTirePressure: Float  // PSI
    let rearRightTirePressure: Float  // PSI
    
    let ballast: Int  // uint8.self
    let fuelLoad: Float
    
    init?(data: inout ByteBuffer) {
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
