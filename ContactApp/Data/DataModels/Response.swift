//
//  UserListResponse.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

// Common `Response` model to fetch model/s nested in the `Data` property of JSON
public struct Response<Data: Codable>: Codable {
    public let data: Data
}
