//
//  SessionDataHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public class SessionDataHandler: PacketHandler {
    typealias PacketType = SessionDataPacket
    
    public func processPacket(data: inout ByteBuffer) {
        let object = PacketType(data: &data)
    }
}
