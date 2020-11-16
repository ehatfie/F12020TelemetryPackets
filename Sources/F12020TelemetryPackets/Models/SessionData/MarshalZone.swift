//
//  MarshalZone.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct MarshalZone {
    public let zoneStart: Float // fraction (0..1) of way through the lap the zone starts
    public let zoneFlag: Int //Int8 // -1 invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
    
    public init?(data: inout ByteBuffer) {
        guard let zoneStart = data.readFloat(),
              let zoneFlag = data.readInt(as: Int8.self)
        else {
            return nil
        }
        self.zoneStart = zoneStart
        self.zoneFlag = zoneFlag
    }
}
