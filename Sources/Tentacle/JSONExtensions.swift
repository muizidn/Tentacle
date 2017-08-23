//
//  JSONExtensions.swift
//  Tentacle
//
//  Created by Matt Diephouse on 3/10/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation
import Result

internal func decode<T: Decodable>(_ payload: Data) -> Result<T, DecodingError> {
    return Result { () -> T in
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        return try decoder.decode(T.self, from: payload)
    }
}

internal func decodeList<T: Decodable>(_ payload: Data) -> Result<[T], DecodingError> {
    return Result { () -> [T] in
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        return try decoder.decode([T].self, from: payload)
    }
}

extension DecodingError: Equatable {
    static public func ==(lhs: DecodingError, rhs: DecodingError) -> Bool {
        switch (lhs, rhs) {
        default: return false // FIXME
        }
    }
}
