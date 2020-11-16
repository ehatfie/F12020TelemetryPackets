//
//  LapDataPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct LapDataPacket {
    /**
     The lap data packet gives details of all the cars in the session.
     Frequency: Rate as specified in menus
     Size: 843 bytes
     Version: 1
     */
    public let header: PacketHeader?
    public let lapData: [LapDataInner] // lap data for all cars on track
    
    init?(header: PacketHeader? = nil, data: inout ByteBuffer) {
        self.header = header
        
        guard let lapDataValue = LapDataInner(data: &data) else { return nil}
        self.lapData = [lapDataValue]
    }
}
