//
//  SesionDataPacket.swift
//
//
//  Created by Erik Hatfield on 7/23/20.
//

import NIO

struct SessionDataPacket {
    let header: PacketHeader?
    let weather: Int                // uint8 0  = clear, 1  = lightCloud, 2  = overcast, 3  = lightRain, 4  = heavyRain, 5  = storm
    let trackTemperature: Int //int8      // track temperature in degrees
    let airTemperature: Int //int8        // air temperature in celcius

    let totalLaps: Int //uint8            // total number of laps in the race
    let trackLength: Int // uint16         // track lenght in meters
    let sessionType: Int // uint8          // 0  = unknown, 1  = Practice 1, 2  = Practice 2, 3  = Practice 3, 4  = short practice 5  = Q1, 6  = Q2, 7  = Q3, 8  = short Qualifying, 9  = One Shot Qualifying, 10  = Race, 11  = Race2, 12  = Time Trial
    let trackId: Int // int8               //  -1 for uknown 0 =21 for tracks in season order
    let m_formula: Int // uint8            // Formula type, 0 = F1 Modern, 1 = F1 Classic, 2 = F2

    let sessionTimeLeft: Int // uint16     // time left in session in seconds
    let sessionDuration: Int // uint16     // session duration in seconds

    let pitSpeedLimiter: Int // uint8        // pit speed limit in km/h

    let gamePaused: Int // Uint8           // whether game is paused
    let isSpectating: Int // uint8         // whether player is spectating
    let spectatorCarIndex: Int // uint8    // index of car being spectated
    let sliProNativeSupport: Int // uint8  // 0 = inactive, 1 = active

    let numMarshalZones: Int // uint8      // number of marshal zones max 21
    let marshalZones: [MarshalZone] // list of marshal zones
    let safetyCarStatus: Int // uint8      // 0 = no safety car, 1 = full safety car, 2 = virtual safety car
    let networkGame: Int // uint8          // 0 = offline, 1 = online
    let numWeatherForecastSamples: Int // uint8
    let weatherForecastSamples: [WeatherForecastSample]

    init?(header: PacketHeader? = nil, data: inout ByteBuffer) {
        self.header = header
        
        guard let weather = data.readInt(as: UInt8.self),
              let trackTemperature = data.readInt(as: UInt8.self),
              let airTemperature = data.readInt(as: UInt8.self),
              let totalLaps = data.readInt(as: UInt8.self),
              let trackLength = data.readInt(as: UInt16.self),
              let sessionType = data.readInt(as: UInt8.self),
              let trackId = data.readInt(as: Int8.self),
              let m_formula = data.readInt(as: UInt8.self),
              let sessionTimeLeft = data.readInt(as: UInt16.self),
              let sessionDuration = data.readInt(as: UInt16.self),
              let pitSpeedLimiter = data.readInt(as: UInt8.self),
              let gamePaused = data.readInt(as: UInt8.self),
              let isSpectating = data.readInt(as: UInt8.self),
              let spectatorCarIndex = data.readInt(as: UInt8.self),
              let sliProNativeSupport = data.readInt(as: UInt8.self),
              let numMarshalZones = data.readInt(as: UInt8.self),
              let safetyCarStatus = data.readInt(as: UInt8.self),
              let networkGame = data.readInt(as: UInt8.self),
              let numWeatherForecastSamples = data.readInt(as: UInt8.self)
        else {
            return nil
        }
              

        self.weather = weather
        self.trackTemperature = trackTemperature
        self.airTemperature = airTemperature

        self.totalLaps = totalLaps
        self.trackLength = trackLength
        self.sessionType = sessionType
        self.trackId = trackId
        self.m_formula = m_formula

        self.sessionTimeLeft = sessionTimeLeft
        self.sessionDuration = sessionDuration

        self.pitSpeedLimiter = pitSpeedLimiter

        self.gamePaused = gamePaused
        self.isSpectating = isSpectating
        self.spectatorCarIndex = spectatorCarIndex
        self.sliProNativeSupport = sliProNativeSupport

        self.numMarshalZones = numMarshalZones

        var raceMarshalZones = [MarshalZone]()
        for _ in 0..<(numMarshalZones ?? 1) {
            guard let marshalZone = MarshalZone(data: &data) else { return nil }
            raceMarshalZones.append(marshalZone)
        }

        self.marshalZones = raceMarshalZones
        self.safetyCarStatus = safetyCarStatus
        self.networkGame = networkGame
        self.numWeatherForecastSamples = numWeatherForecastSamples

        var forecastSamples = [WeatherForecastSample]()

        for _ in 0..<(self.numWeatherForecastSamples ?? 0) {
            guard let forecast = WeatherForecastSamples(data: &data) else { return nil }
            forecastSamples.append(forecast)
        }

        self.weatherForecastSamples = forecastSamples
    }
}

public struct SessionData: Codable {
    let sessionType: SessionType
    let weather: WeatherType
    let trackName: String
    let totalLaps: Int
    let sessionTimeLeft: Int
    let sessionDuration: Int

    enum CodingKeys: CodingKey {
        case sessionType, weather, totalLaps, trackName, sessionTimeLeft, sessionDuration
    }

    init(from data: SessionDataPacket) {
        self.sessionType = SessionType(from: data.sessionType)
        self.weather = WeatherType(from: data.weather)
        self.totalLaps = data.totalLaps ?? -1
        self.trackName = TrackIDs[data.trackId ?? -1] ?? "Unrecognized Track"
        self.sessionTimeLeft = data.sessionTimeLeft ?? -1
        self.sessionDuration = data.sessionDuration ?? -1
    }

    // not using
    init(from decoder: Decoder) throws {
        self.sessionType = .unknown
        self.weather = .unknown
        self.trackName = "Unknown"
        self.totalLaps = -1
        self.sessionTimeLeft = -1
        self.sessionDuration = -1
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionType.value, forKey: .sessionType)
        try container.encode(weather.value, forKey: .weather)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(totalLaps, forKey: .totalLaps)
        try container.encode(sessionTimeLeft, forKey: .sessionTimeLeft)
        try container.encode(sessionDuration, forKey: .sessionDuration)
    }
}
