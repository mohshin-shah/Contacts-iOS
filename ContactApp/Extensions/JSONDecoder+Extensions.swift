//
//  JSONDecoder+Helpers.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

extension JSONDecoder {
    /// Returns a JSONDecoder with custom decoding strategies eg .convertFromSnakeCase
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
