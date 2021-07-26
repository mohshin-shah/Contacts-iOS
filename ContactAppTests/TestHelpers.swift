//
//  TestHelpers.swift
//  ContactAppTests
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
// Reference: https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
extension Bundle {
    enum BundleDecodeError: Error {
        case genericError(reason: String)
    }
    
    func decode<T: Decodable>(
        _ type: T.Type,
        from file: String,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw BundleDecodeError.genericError(reason: "Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw BundleDecodeError.genericError(reason: "Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        return try decoder.decode(T.self, from: data)
    }
}
