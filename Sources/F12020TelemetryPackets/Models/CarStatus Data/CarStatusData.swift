//
//  CarStatusData.swift
//  
//
//  Created by Erik Hatfield on 6/13/21.
//

import Foundation
import NIO

public struct CarStatusData {
    public let tractionControl: Int //uint8
    public let antiLockBreaks: Int // uint8
    public let fuelMix: Int //uint8
    public let frontBrakeBias: Int // uint8
    public let pitLimiterStatus: Int // uint8
    public let fuelInTank: Float // float
    public let fuelCapacity: Float // float
    public let fuelRemainingLaps: Float // float
    public let maxRPM: Int // uint16
    public let idleRPM: Int // uint16
    public let maxGears: Int // uint8
    public let drsAllowed: Int // uint8
    public let drsActivationDistance: Int // uint16
    public let tiresWear: [Int] // uint8 * 4
    public let actualTireCompound: Int // uint8
    public let visualTireCompound: Int // uint8
    public let tiresAgeLaps: Int // uint8
    public let tiresDamage: [Int] // uint8
    public let frontLeftWingDamage: Int // uint8
    public let frontRightWingDamage: Int // uint8
    public let rearWingDamage: Int // uint8
    public let drsFault: Int // uint8
    public let engineDamage: Int // uint8
    public let gearBoxDamage: Int // uint8
    public let vehicleFiaFlags: Int // uint8
    public let ersStoreEnergy: Float // float
    public let ersDeployMode: Int // uint8
    public let ersHarvestedThisLapMGUK: Float // float
    public let ersHarvestedThisLapMGUH: Float // float
    public let ersDeployedThisLap: Float // float
    
    public init?(data: inout ByteBuffer) {
        guard let tractionControl = data.readInt(as: UInt8.self),
              let antiLockBreaks = data.readInt(as: UInt8.self),
              let fuelMix = data.readInt(as: UInt8.self),
              let frontBrakeBias = data.readInt(as: UInt8.self),
              let pitLimiterStatus = data.readInt(as: UInt8.self),
              let fuelInTank = data.readFloat(),
              let fuelCapacity = data.readFloat(),
              let fuelRemainingLaps = data.readFloat(),
              let maxRPM = data.readInt(as: UInt16.self),
              let idleRPM = data.readInt(as: UInt16.self),
              let maxGears = data.readInt(as: UInt8.self),
              let drsAllowed = data.readInt(as: UInt8.self),
              let drsActivationDistance = data.readInt(as: UInt16.self),
              let tiresWear = data.readMultipleInt(count: 4, as: UInt8.self),
              let actualTireCompound = data.readInt(as: UInt8.self),
              let visualTireCompound = data.readInt(as: UInt8.self),
              let tiresAgeLaps = data.readInt(as: UInt8.self),
              let tiresDamage = data.readMultipleInt(count: 4, as: UInt8.self),
              let frontLeftWingDamage = data.readInt(as: UInt8.self),
              let frontRightWingDamage = data.readInt(as: UInt8.self),
              let rearWingDamage = data.readInt(as: UInt8.self),
              let drsFault = data.readInt(as: UInt8.self),
              let engineDamage = data.readInt(as: UInt8.self),
              let gearBoxDamage = data.readInt(as: UInt8.self),
              let vehicleFiaFlags = data.readInt(as: UInt8.self),
              let ersStoreEnergy = data.readFloat(),
              let ersDeployMode = data.readInt(as: UInt8.self),
              let ersHarvestedThisLapMGUK = data.readFloat(),
              let ersHarvestedThisLapMGUH = data.readFloat(),
              let ersDeployedThisLap = data.readFloat()
        else {
            return nil
        }
        
        self.tractionControl = tractionControl
        self.antiLockBreaks = antiLockBreaks
        self.fuelMix = fuelMix
        self.frontBrakeBias = frontBrakeBias
        self.pitLimiterStatus = pitLimiterStatus
        self.fuelInTank = fuelInTank
        self.fuelCapacity = fuelCapacity
        self.fuelRemainingLaps = fuelRemainingLaps
        self.maxRPM = maxRPM
        self.idleRPM = idleRPM
        self.maxGears = maxGears
        self.drsAllowed = drsAllowed
        self.drsActivationDistance = drsActivationDistance
        self.tiresWear = tiresWear
        self.actualTireCompound = actualTireCompound
        self.visualTireCompound = visualTireCompound
        self.tiresAgeLaps = tiresAgeLaps
        self.tiresDamage = tiresDamage
        self.frontLeftWingDamage = frontLeftWingDamage
        self.frontRightWingDamage = frontRightWingDamage
        self.rearWingDamage = rearWingDamage
        self.drsFault = drsFault
        self.engineDamage = engineDamage
        self.gearBoxDamage = gearBoxDamage
        self.vehicleFiaFlags = vehicleFiaFlags
        self.ersStoreEnergy = ersStoreEnergy
        self.ersDeployMode = ersDeployMode
        self.ersHarvestedThisLapMGUK = ersHarvestedThisLapMGUK
        self.ersHarvestedThisLapMGUH = ersHarvestedThisLapMGUH
        self.ersDeployedThisLap = ersDeployedThisLap
        
    }
}
