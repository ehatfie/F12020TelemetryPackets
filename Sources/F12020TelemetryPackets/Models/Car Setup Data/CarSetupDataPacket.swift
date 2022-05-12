//
//  CarSetupPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public protocol IsPacket {
    var header: PacketHeader { get set }
}

public struct CarSetupPacket: IsPacket {
    public var header: PacketHeader
    public let carSetups: [CarSetupData]
    
    public init?(header: PacketHeader, data: inout ByteBuffer) {
        self.header = header
        guard let packet =  CarSetupData(data: &data) else { return nil }
        
        self.carSetups = [packet]
    }
}
