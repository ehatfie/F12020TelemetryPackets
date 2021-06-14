//
//  CarStatusPacket.swift
//  
//
//  Created by Erik Hatfield on 6/13/21.
//

import Foundation
import NIO

public struct CarStatusPacket {
    public let header: PacketHeader
    public let carStatusData: [CarStatusData]
    
    public init?(header: PacketHeader, data: inout ByteBuffer) {
        var carStatusData = [CarStatusData]()
        
        for _ in 0...21 {
            if let carStatus = CarStatusData(data: &data) {
                carStatusData.append(carStatus)
            }
        }
        guard carStatusData.count > 0 else {
            return nil
        }
        self.header = header
        self.carStatusData = carStatusData
    }
}
