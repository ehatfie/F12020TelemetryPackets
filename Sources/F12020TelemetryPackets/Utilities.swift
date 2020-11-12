//
//  Utilities.swift
//  
//
//  Created by Erik Hatfield on 11/9/20.
//

import Foundation
import NIO

extension ByteBuffer {
    mutating func readInt<T: FixedWidthInteger>(as: T.Type = T.self) -> Int? {
        guard let data = self.readInteger(endianness: .little, as: T.self) else { return nil }
        return Int(truncatingIfNeeded: data)
    }
    mutating func readMultipleInt<T: FixedWidthInteger>(count: Int, as type: T.Type = T.self) -> [Int]? {
        var readValues: [Int]? = []
        
        for _ in 0 ..< count {
            guard let value = self.readInt(as: type) else { return  nil }
            readValues?.append(value)
        }
        
        return readValues
    }
    
    mutating func readFloat() -> Float? {
        return self.readInteger(endianness: .little, as: UInt32.self).map { Float(bitPattern: $0) }
    }
    
    mutating func readMultipleFloat(count: Int) -> [Float]? {
        var readValues: [Float]? = []
        
        for _ in 0 ..< count {
            guard let value = self.readFloat() else { return  nil }
            readValues?.append(value)
        }
        
        return readValues
    }
    
    func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBytes {
            $0.baseAddress!.load(as: T.self)
        }
    }
}

