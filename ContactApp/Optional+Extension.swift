//
//  Optional+Extension.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
