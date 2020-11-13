//
//  CarSetupPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct CarSetupPacket {
    let header: PacketHeader
    let carSetups: [CarSetupData]
    
    init?(header: PacketHeader, data: inout ByteBuffer) {
        self.header = header
        guard let packet =  CarSetupData(data: &data) else { return nil }
        print("CAR SETUP \(packet)")
        self.carSetups = [packet]
    }
}
