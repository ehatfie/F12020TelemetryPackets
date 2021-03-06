//
//  File.swift
//  
//
//  Created by Erik Hatfield on 11/10/20.
//

import Foundation
import NIO

// todo: move this
protocol PacketHandler {
    func processPacket(data: inout ByteBuffer)
}

struct E: Error {
    
}

public struct PacketInfo: Hashable {
    public let packetFormat: Int
    public let packetVersion: Int
    public let packetType: PacketType
    
    public init (format: Int?, version: Int?, type: Int?) throws {
        guard
            let format = format,
            let version = version,
            let type = type
        else {
            throw E()
        }
        
        self.packetFormat = format
        self.packetVersion = version
        self.packetType = PacketType(rawValue: type) ?? .none
    }
    
    public init (format: UInt16?, version: UInt8?, type: UInt8?) throws {
        guard
            let format = format,
            let version = version,
            let type = type
        else {
            throw E()
        }
        
        self.packetFormat = Int(format)
        self.packetVersion = Int(version)
        self.packetType = PacketType(rawValue: Int(type)) ?? .none
    }
    
    // default initializer
    public init (format: Int, version: Int, type: Int) {
        self.packetFormat = format
        self.packetVersion = version
        self.packetType = PacketType(rawValue: type) ?? .none
    }
}

//let HeaderFieldsToPacketType: [PacketInfo: PacketHandler] = [
////    PacketInfo(format: 2020, version: 1, type: 0): MotionDataPacketHandler(),
//    PacketInfo(format: 2020, version: 1, type: 1): SessionDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 2): LapDataHandler(),
////    PacketInfo(format: 2020, version: 1, type: 3): EventDataHandler(),
////    PacketInfo(format: 2020, version: 1, type: 4): ParticipantDataHandler(),
////    PacketInfo(format: 2020, version: 1, type: 5): CarSetupDataHandler(),
////    PacketInfo(format: 2020, version: 1, type: 6): CarTelemetryDataHandler(),
////    PacketInfo(format: 2020, version: 1, type: 7): CarStatusDataHandler()
//]

public enum PacketType: Int {
    case Motion = 0
    case SessionData = 1
    case LapData = 2
    case EventData = 3
    case Participants = 4
    case CarSetups = 5
    case CarTelemetry = 6
    case CarStatus = 7
    case FinalClassification = 8
    case LobbyInfo = 9
    case none = -1
    
    public var shortDescription: String {
        switch self {
        case .Motion:
            return "Motion"
        case .SessionData:
            return "Session"
        case .LapData:
            return "Lap Data"
        case .EventData:
            return "Event"
        case .Participants:
            return "Participants"
        case .CarSetups:
            return "Car Setups"
        case .CarTelemetry:
            return "Car Telemetry"
        case .CarStatus:
            return "Car Status"
        case .FinalClassification:
            return "Final Classification"
        case .LobbyInfo:
            return "Lobby Information"
        case
            .none: return "NA"
        }
    }
    
//    var handler: PacketHandler.Type? {
//        switch self {
//        case .SessionData:
//            return SessionDataHandler.self
//        case .LapData:
//            return LapDataHandler.self
//        default:
//            return nil
//        }
//    }
}
