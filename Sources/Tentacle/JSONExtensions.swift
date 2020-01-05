//
//  JSONExtensions.swift
//  Tentacle
//
//  Created by Matt Diephouse on 3/10/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation

internal func decode<T: Decodable>(_ payload: Data) -> Result<T, DecodingError> {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        let data = try decoder.decode(T.self, from: payload)
        return Result.success(data)
    } catch let e as DecodingError {
        return Result.failure(e)
    } catch {
        fatalError("Unhandled \(error)")
    }
    
}

internal func decodeList<T: Decodable>(_ payload: Data) -> Result<[T], DecodingError> {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        let data = try decoder.decode([T].self, from: payload)
        return Result.success(data)
    } catch let e as DecodingError {
        return Result.failure(e)
    } catch {
        fatalError("Unhandled \(error)")
    }
}

extension DecodingError.Context: Equatable {
    public static func ==(lhs: DecodingError.Context, rhs: DecodingError.Context) -> Bool {
        return lhs.debugDescription == rhs.debugDescription
    }
}

extension DecodingError: Equatable {
    public static func ==(lhs: DecodingError, rhs: DecodingError) -> Bool {
        switch (lhs, rhs) {
        case (.dataCorrupted(let lContext), .dataCorrupted(let rContext)):
            return lContext == rContext
        case (.keyNotFound(let lKey, let lContext), .keyNotFound(let rKey, let rContext)):
            return lKey.stringValue == rKey.stringValue && lContext == rContext
        case (.typeMismatch(let lType, let lContext), .typeMismatch(let rType, let rContext)):
            return lType == rType && lContext == rContext
        case (.valueNotFound(let lType, let lContext), .valueNotFound(let rType, let rContext)):
            return lType == rType && lContext == rContext
        default:
            return false
        }
    }
}
