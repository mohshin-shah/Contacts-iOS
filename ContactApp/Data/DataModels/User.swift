//
//  File.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

struct User: Codable {
    let id: Identifier<User>
    let avatar: URL
    let email: String
    let firstName: String
    let lastName: String
}

// Phantom type to enable better type safety at compile time.
// eg. Prevent use of simple integer value wherever User's id is expected
struct Identifier<T>: Codable {
    let value: Int
    
    init(from decoder: Decoder) throws { self.value = try Int(from: decoder) }
    
    func encode(to encoder: Encoder) throws { try value.encode(to: encoder) }
}
