//
//  PacketHeader.swift
//  
//
//  Created by Erik Hatfield on 11/9/20.
//

import Foundation
import NIO

public struct PacketHeader {
    public let packetFormat: Int // game year packet type eg 2020
    public let gameMajorVersion: Int //uint8 // vX.00
    public let gameMinorVersion: Int //uint8 // v1.XX
    public let packetVersion: Int //uint8 //version of packet type
    public let packetId: Int //uint8 // packet type
    public let sessionUID: Int //uint64 // unique session identifier
    public let sessionTime: Float // session timestamp
    public let frameIdentifier: Int // uint32 // Identifier for which frame the packet was retrieved on
    public let playerCarIndex: Int //uint8 // index of players car
    public let secondaryPlayerCarIndex: Int // UInt8? // index of secondary players car, 255 if no second player
    
    init?(data: inout ByteBuffer) {
        guard let packetFormat = data.readInt(as: UInt16.self),
              let gameMajorVersion = data.readInt(as: UInt8.self),
              let gameMinorVersion = data.readInt(as: UInt8.self),
              let packetVersion = data.readInt(as: UInt8.self),
              let packetId = data.readInt(as: UInt8.self),
              let sessionUID = data.readInt(as: UInt64.self),
              let sessionTime = data.readFloat(),
              let frameIdentifier = data.readInt(as: UInt32.self),
              let playerCarIndex = data.readInt(as: UInt8.self),
              let secondaryPlayerCarIndex = data.readInt(as: UInt8.self)
        else {
            return nil
        }
        
        self.packetFormat = packetFormat
        self.gameMajorVersion = gameMajorVersion
        self.gameMinorVersion = gameMinorVersion
        self.packetVersion = packetVersion
        self.packetId = packetId
        self.sessionUID = sessionUID
        self.sessionTime = sessionTime
        self.frameIdentifier = frameIdentifier
        self.playerCarIndex = playerCarIndex
        self.secondaryPlayerCarIndex = secondaryPlayerCarIndex
    }
}
