//
//  PacketHeader.swift
//  
//
//  Created by Erik Hatfield on 11/9/20.
//

import Foundation
import NIO

struct PacketHeader {
    let packetFormat: UInt16? // game year packet type eg 2020
    let gameMajorVersion: UInt8? //uint8 // vX.00
    let gameMinorVersion: UInt8? //uint8 // v1.XX
    let packetVersion:  UInt8? //uint8 //version of packet type
    let packetId: UInt8? //uint8 // packet type
    let sessionUID: UInt64? //uint64 // unique session identifier
    let sessionTime: Float? // session timestamp
    let frameIdentifier: UInt32? // uint32 // Identifier for which frame the packet was retrieved on
    let playerCarIndex: UInt8? //uint8 // index of players car
    let secondaryPlayerCarIndex: UInt8? // UInt8? // index of secondary players car, 255 if no second player
    
    init(data: inout ByteBuffer) throws {
        self.packetFormat = data.readInteger(endianness: .little, as: UInt16.self)
        self.gameMajorVersion = data.readInteger(endianness: .little, as: UInt8.self)
        self.gameMinorVersion = data.readInteger(endianness: .little, as: UInt8.self)
        self.packetVersion = data.readInteger(endianness: .little, as: UInt8.self)
        self.packetId = data.readInteger(endianness: .little, as: UInt8.self)
        self.sessionUID = data.readInteger(endianness: .little, as: UInt64.self)
        self.sessionTime = data.readFloat()
        self.frameIdentifier = data.readInteger(endianness: .little, as: UInt32.self)
        self.playerCarIndex = data.readInteger(endianness: .little, as: UInt8.self)
        self.secondaryPlayerCarIndex = data.readInteger(endianness: .little, as: UInt8.self)
    }
}
