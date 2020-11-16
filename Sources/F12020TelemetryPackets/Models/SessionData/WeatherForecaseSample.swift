//
//  WeatherForecastSample.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct WeatherForecastSample {
    public let sessionType: Int // 0 = unknown, 1 = P1, 2 = P2, 3 = P3, 4 = Short P, 5 = Q1, 6 = Q2, 7 = Q3, 8 = Short Q, 9 = OSQ, 10 = R, 11 = R2
    public let timeOffset: Int // Time in minutes the forecast is for
    public let weather: Int // Weather - 0 = clear, 1 = light cloud, 2 = overcast // can be enum
    public let trackTemperature: Int // Track temp in degrees Celsius
    public let airTemperature: Int // air temp in degrees Celsius
    
    public init?(data: inout ByteBuffer) {
        guard let sessionType = data.readInt(as: UInt8.self),
              let timeOffset = data.readInt(as: UInt8.self),
              let weather = data.readInt(as: UInt8.self),
              let trackTemperature = data.readInt(as: UInt8.self),
              let airTemperature = data.readInt(as: UInt8.self)
        else {
            return nil
        }
              
        self.sessionType = sessionType
        self.timeOffset = timeOffset
        self.weather = weather
        self.trackTemperature = trackTemperature
        self.airTemperature = airTemperature
    }
}
