//
//  SessionDataHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

class SessionDataHandler: PacketHandler {
    typealias PacketType = SessionDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        let object = PacketType(data: &data)
    }
}
