//
//  LapDataInner.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct LapDataInner: Codable {
    public let lastLapTime: Float
    public let currentLapTime: Float
    
    public let sector1Time: Int          // sector 1 time in milliseconds
    public let sector2Time: Int          // sector 2 time in milliseconds
    
    public let bestLapTime: Float          // best lap time of the session
    public let bestLapNum: Int           // Lap number the best lap time was set on
    public let bestLapSector1Time: Int  // sector 1 time of the best lap in the session in milliseconds
    public let bestLapSector2Time: Int  // sector 2 time of the best lap in the session in milliseconds
    public let bestLapSector3Time: Int  // sector 3 time of the best lap in the session in milliseconds
    
    public let bestOverallSector1Time: Int // Best overall sector 1 time of the session
    public let bestOverallSector1LapNum: Int // Lap number of best overall sector 1 time
    public let bestOverallSector2Time: Int // Best overall sector 2 time of the session
    public let bestOverallSector2LapNum: Int // lap number of best overall sector 2 time
    public let bestOverallSector3Time: Int // best overall sector 3 time of the session
    public let bestOverallSector3LapNum: Int // lap numbe rof best overall sector 3 time
    
    public let lapDistance: Float          // distance car is around current lap in meters
    public let totalDistance: Float        // total distance travelled in session in meters
    
    public let safetyCarDelta: Float       // delta in seconds for safety car
    public let carPosition: Int            // uint8 car race position
    public let currentLapNum: Int          // uint8
    public let pitStatus: Int              // uint8 0 = none, 1 = pitting, 2 = in pits
    public let sector: Int                 // uint8 0 = sector1, 1 = sector2, etc
    public let currentLapInvalid: Int      // uint8 0 =  valid, 1 = invalid
    public let penalties: Int              // uint8 accumulated time penalties in seconds
    public let gridPosition: Int           // uint8 grid position vehicle started in
    public let driverStatus: Int           // uint8 0 = inGarage, 1 = flyingLap, 2 = inLap, 3 = outLap, 4 = onTrack
    public let resultStatus: Int           // uint8 0 = invalid, 1 = inactive, 2 = active, 3 = finished, 4 = disqualified, 5 = notClassified, 6 = retired
    
    public init?(data: inout ByteBuffer) {
        guard let lastLapTime = data.readFloat(),
              let currentLapTime = data.readFloat(),
              let sector1Time = data.readInt(as: UInt16.self),
              let sector2Time = data.readInt(as: UInt16.self),
              let bestLapTime = data.readFloat(),
              let bestLapNum = data.readInt(as: UInt8.self),
              let bestLapSector1Time = data.readInt(as: UInt16.self),
              let bestLapSector2Time = data.readInt(as: UInt16.self),
              let bestLapSector3Time = data.readInt(as: UInt16.self),
              let bestOverallSector1Time = data.readInt(as: UInt16.self),
              let bestOverallSector2Time = data.readInt(as: UInt16.self),
              let bestOverallSector3Time = data.readInt(as: UInt16.self),
              let bestOverallSector1LapNum = data.readInt(as: UInt8.self),
              let bestOverallSector2LapNum = data.readInt(as: UInt8.self),
              let bestOverallSector3LapNum = data.readInt(as: UInt8.self),
              let lapDistance = data.readFloat(),
              let totalDistance = data.readFloat(),
              let safetyCarDelta = data.readFloat(),
              let carPosition = data.readInt(as: UInt8.self),
              let currentLapNum = data.readInt(as: UInt8.self),
              let pitStatus = data.readInt(as: UInt8.self),
              let sector = data.readInt(as: UInt8.self),
              let currentLapInvalid = data.readInt(as: UInt8.self),
              let penalties = data.readInt(as: UInt8.self),
              let gridPosition = data.readInt(as: UInt8.self),
              let driverStatus = data.readInt(as: UInt8.self),
              let resutlStatus = data.readInt(as: UInt8.self)
        else {
            return nil
        }
              
        self.lastLapTime = lastLapTime
        self.currentLapTime = currentLapTime
        
        self.sector1Time = sector1Time
        self.sector2Time = sector2Time
        
        self.bestLapTime = bestLapTime
        self.bestLapNum = bestLapNum
        
        self.bestLapSector1Time = bestLapSector1Time
        self.bestLapSector2Time = bestLapSector2Time
        self.bestLapSector3Time = bestLapSector3Time
        
        self.bestOverallSector1Time = bestOverallSector1Time
        self.bestOverallSector2Time = bestOverallSector2Time
        self.bestOverallSector3Time = bestOverallSector3Time
        
        self.bestOverallSector1LapNum = bestOverallSector1LapNum
        self.bestOverallSector2LapNum = bestOverallSector2LapNum
        self.bestOverallSector3LapNum = bestOverallSector3LapNum
        
        self.lapDistance = lapDistance
        self.totalDistance = totalDistance
        
        self.safetyCarDelta = safetyCarDelta
        self.carPosition = carPosition
        self.currentLapNum = currentLapNum
        self.pitStatus = pitStatus
        self.sector = sector
        self.currentLapInvalid = currentLapInvalid
        self.penalties = penalties
        self.gridPosition = gridPosition
        self.driverStatus = driverStatus
        self.resultStatus = resutlStatus
    }
    
    public init() {
        self.lastLapTime = 0
        self.currentLapTime = 0
        self.sector1Time = 0
        self.sector2Time = 0
        self.bestLapTime = 0
        self.bestLapNum = 0
        self.bestLapSector1Time = 0
        self.bestLapSector2Time = 0
        self.bestLapSector3Time = 0
        self.bestOverallSector1Time = 0
        self.bestOverallSector1LapNum = 0
        self.bestOverallSector2Time = 0
        self.bestOverallSector2LapNum = 0
        self.bestOverallSector3Time = 0
        self.bestOverallSector3LapNum = 0
        self.lapDistance = 0
        self.totalDistance = 0
        self.safetyCarDelta = 0
        self.carPosition = 0
        self.currentLapNum = 0
        self.pitStatus = 0
        self.sector = 0
        self.currentLapInvalid = 0
        self.penalties = 0
        self.gridPosition = 0
        self.driverStatus = 0
        self.resultStatus = 0
    }
}

extension LapDataInner: Identifiable {
    public var id: Int { currentLapNum }
}

public struct LapDataSimple: Codable {
    public let bestLapTime: Double
    public let currentLapTime: Double
    public let lastLapTime: Double
    
    public init(from data: LapDataInner) {
        let best = Double(round((Double(data.bestLapTime)) * 100)/100)
        let current = Double(round((Double(data.currentLapTime)) * 100)/100)
        let last = Double(round((Double(data.lastLapTime)) * 100)/100)
        
        self.bestLapTime = best
        self.currentLapTime = current
        self.lastLapTime = last
    }
}
