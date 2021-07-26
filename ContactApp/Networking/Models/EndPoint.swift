//
//  EndPoint.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import Alamofire

protocol Endpoint: URLRequestConvertible {
    static var baseURL: URL? { get set }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameter: RequestParameterEncodable? { get }
}

// Protocol to allow adding paramters in the request
protocol RequestParameterEncodable {
    func encode(into request: URLRequest) throws -> URLRequest
}

extension Endpoint {
    var parameter: RequestParameterEncodable? { nil }

    func asURLRequest() throws -> URLRequest {
        guard let baseURL = Self.baseURL else {
            let message = "Base URL (\(Self.self)) must not be nil. Please configure it in NetworkManager."
            fatalError(message)
        }
        return try asURLRequest(withURL: baseURL)
    }

    func asURLRequest(withURL baseURL: URL) throws -> URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        var urlRequest = try URLRequest(url: url, method: method)
        // Allow adding paramters in the request if needed
        if let param = parameter {
            urlRequest = try param.encode(into: urlRequest)
        }
        return urlRequest
    }
}
