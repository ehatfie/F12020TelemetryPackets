//
//  File.swift
//  
//
//  Created by Erik Hatfield on 6/5/21.
//

import Foundation

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
