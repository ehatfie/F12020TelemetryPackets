//
//  File.swift
//  
//
//  Created by Erik Hatfield on 11/10/21.
//

import Foundation

public enum DriverStatus: Int {
    case garage = 0
    case flyingLap = 1
    case inLap = 2
    case outLap = 3
    case onTrack = 4
    case unknown = -1
    
    public init(from value: Int) {
        guard let status = DriverStatus(rawValue: value) else { self = .unknown; return }
        self = status
    }
    
    public var value: String {
        switch self {
        case .garage:
            return "Garage"
        case .flyingLap:
            return "Flying Lap"
        case .inLap:
            return "In Lap"
        case .outLap:
            return "Out Lap"
        case .onTrack:
            return "On Track"
        default:
            return "Unknown"
        }
    }
}
