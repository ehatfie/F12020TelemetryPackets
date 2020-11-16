//
// CarTelemetryPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

public struct CarTelemetryDataPacket {
    public let header: PacketHeader
    public let carTelemetryData: [CarTelemetryData]
    public let buttonStatus: Int // uint32 fit flags specifying which buttons are being pressed
    public let mfdPanelIndex: Int // uint8 Index of MFD Panel open - 255 = MCD closed
                             // singleplayer, race - 0 =  Car setup, 1 = Pits 2 = Damage, 3 = Enigne, 4 = Temperature
    public let mfdPanelIndexSecondaryPlayer: Int //UInt8, same as above
    public let suggestedGear: Int //Int8 //suggested gear for the player (1-8) and 0 if no gear selected
    
    init?(header: PacketHeader, data: inout ByteBuffer) {
        self.header = header
        guard let packet = CarTelemetryData(data: &data),
              let buttonStatus = data.readInt(as: UInt32.self),
              let mfdPanelIndex = data.readInt(as: UInt8.self),
              let mdfPanelIndexSecondaryPlayer = data.readInt(as: UInt8.self),
              let suggestedGear = data.readInt(as: Int8.self)
              else { return nil }
        self.carTelemetryData = [packet]
        
        self.buttonStatus = data.readInt(as: UInt32.self)
        self.mfdPanelIndex = data.readInt(as: UInt8.self)
        self.mfdPanelIndexSecondaryPlayer = data.readInt(as: UInt8.self)
        self.suggestedGear = data.readInt(as: Int8.self)
    }
}
