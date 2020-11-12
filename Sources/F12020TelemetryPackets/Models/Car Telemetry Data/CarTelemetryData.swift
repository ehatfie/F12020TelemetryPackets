//
//  CarTelemetryData.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

struct CarTelemetryData {
    let speed: Int  // uint 16 speed in kmh
    let throttle: Float // amount of throttle 0.0 - 1.0
    let steer: Float // -1.0 = full left, 1.0 = full right
    let brake: Float // amount of brake 0 to 100
    let clutch: Int // uint8 amount of clutch 0 to 100
    let gear: Int // int8 gear selected -1 = r, 0 = N, 1 - 7
    let engineRPM: Int // uint16
    let drs: Int // uint8 0 = off, 1 = on
    let revLightsPercent: Int // uint8
    let brakesTemperature: [Int] // uint16 * 4 celcius
    let tiresSurfaceTemperature: [Int] // uint16 * 4 celcius
    let tiresInnerTemperature: [Int] // uint16 * 4
    let engineTemperature: Int // uint 16 temp in celcius
    let tirePressure: [Float] //
    let surfaceType: Int // uint8 driving surface, make enum??
    
    init?(data: inout ByteBuffer) {
        guard let speed = data.readInt(as: UInt16.self),
              let throttle = data.readFloat(),
              let steer = data.readFloat(),
              let brake = data.readFloat(),
              let clutch = data.readInt(as: UInt8.self),
              let gear = data.readInt(as: UInt8.self),
              let engineRPM = data.readInt(as: UInt16.self),
              let drs = data.readInt(as: UInt8.self),
              let revLightsPercent = data.readInt(as: UInt8.self),
              let brakesTemperatures = data.readMultipleInt(count: 4,as: UInt16.self),
              let tiresSurfaceTemperatures = data.readMultipleInt(count: 4,as: UInt16.self),
              let tiresInnerTemperatures = data.readMultipleInt(count: 4,as: UInt16.self),
              let engineTemperature = data.readInt(as: UInt16.self),
              let pressures = data.readMultipleFloat(count: 4),
              let surfaceType = data.readInt(as: UInt8.self)
        else {
            return nil
        }
              
        self.speed = speed
        self.throttle = throttle
        self.steer = steer
        self.brake = brake
        self.clutch = clutch
        self.gear = gear
        self.engineRPM = engineRPM
        self.drs = drs
        self.revLightsPercent = revLightsPercent
        self.brakesTemperature = brakesTemperatures
        self.tiresSurfaceTemperature = tiresSurfaceTemperatures
        self.tiresInnerTemperature = tiresInnerTemperatures
        self.engineTemperature = engineTemperature
        self.tirePressure = pressures
        self.surfaceType = surfaceType
    }
}
