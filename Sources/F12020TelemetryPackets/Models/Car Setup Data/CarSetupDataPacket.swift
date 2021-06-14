//
//  CarSetupPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct CarSetupPacket {
    public let header: PacketHeader
    public let carSetups: [CarSetupData]
    
    public init?(header: PacketHeader, data: inout ByteBuffer) {
        self.header = header
        guard let packet =  CarSetupData(data: &data) else { return nil }
        
        self.carSetups = [packet]
    }
}
