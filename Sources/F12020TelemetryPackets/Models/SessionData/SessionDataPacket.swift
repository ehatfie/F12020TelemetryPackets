//
//  SesionDataPacket.swift
//
//
//  Created by Erik Hatfield on 7/23/20.
//

import NIO

public struct SessionDataPacket {
    public let header: PacketHeader?
    public let weather: Int                // uint8 0  = clear, 1  = lightCloud, 2  = overcast, 3  = lightRain, 4  = heavyRain, 5  = storm
    public let trackTemperature: Int //int8      // track temperature in degrees
    public let airTemperature: Int //int8        // air temperature in celcius

    public let totalLaps: Int //uint8            // total number of laps in the race
    public let trackLength: Int // uint16         // track lenght in meters
    public let sessionType: Int // uint8          // 0  = unknown, 1  = Practice 1, 2  = Practice 2, 3  = Practice 3, 4  = short practice 5  = Q1, 6  = Q2, 7  = Q3, 8  = short Qualifying, 9  = One Shot Qualifying, 10  = Race, 11  = Race2, 12  = Time Trial
    public let trackId: Int // int8               //  -1 for uknown 0 =21 for tracks in season order
    public let m_formula: Int // uint8            // Formula type, 0 = F1 Modern, 1 = F1 Classic, 2 = F2

    public let sessionTimeLeft: Int // uint16     // time left in session in seconds
    public let sessionDuration: Int // uint16     // session duration in seconds

    public let pitSpeedLimiter: Int // uint8        // pit speed limit in km/h

    public let gamePaused: Int // Uint8           // whether game is paused
    public let isSpectating: Int // uint8         // whether player is spectating
    public let spectatorCarIndex: Int // uint8    // index of car being spectated
    public let sliProNativeSupport: Int // uint8  // 0 = inactive, 1 = active

    public let numMarshalZones: Int // uint8      // number of marshal zones max 21
    public let marshalZones: [MarshalZone] // list of marshal zones
    public let safetyCarStatus: Int // uint8      // 0 = no safety car, 1 = full safety car, 2 = virtual safety car
    public let networkGame: Int // uint8          // 0 = offline, 1 = online
    public let numWeatherForecastSamples: Int // uint8
    public let weatherForecastSamples: [WeatherForecastSample]

    public init?(header: PacketHeader? = nil, data: inout ByteBuffer) {
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
        for _ in 0 ..< numMarshalZones {
            guard let marshalZone = MarshalZone(data: &data) else { return nil }
            raceMarshalZones.append(marshalZone)
        }

        self.marshalZones = raceMarshalZones
        self.safetyCarStatus = safetyCarStatus
        self.networkGame = networkGame
        self.numWeatherForecastSamples = numWeatherForecastSamples

        var forecastSamples = [WeatherForecastSample]()

        for _ in 0 ..< self.numWeatherForecastSamples {
            guard let forecast = WeatherForecastSample(data: &data) else { return nil }
            forecastSamples.append(forecast)
        }

        self.weatherForecastSamples = forecastSamples
    }
}

public struct SessionData: Codable {
    public let sessionType: SessionType
    public let weather: WeatherType
    public let trackName: String
    public let totalLaps: Int
    public let sessionTimeLeft: Int
    public let sessionDuration: Int

    enum CodingKeys: CodingKey {
        case sessionType, weather, totalLaps, trackName, sessionTimeLeft, sessionDuration
    }

    public init(from data: SessionDataPacket) {
        self.sessionType = SessionType(from: data.sessionType)
        self.weather = WeatherType(from: data.weather)
        self.totalLaps = data.totalLaps
        self.trackName = TrackIDs[data.trackId] ?? "Unrecognized Track"
        self.sessionTimeLeft = data.sessionTimeLeft
        self.sessionDuration = data.sessionDuration
    }

    // not using
    public init(from decoder: Decoder) throws {
        self.sessionType = .unknown
        self.weather = .unknown
        self.trackName = "Unknown"
        self.totalLaps = -1
        self.sessionTimeLeft = -1
        self.sessionDuration = -1
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionType.value, forKey: .sessionType)
        try container.encode(weather.value, forKey: .weather)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(totalLaps, forKey: .totalLaps)
        try container.encode(sessionTimeLeft, forKey: .sessionTimeLeft)
        try container.encode(sessionDuration, forKey: .sessionDuration)
    }
}
