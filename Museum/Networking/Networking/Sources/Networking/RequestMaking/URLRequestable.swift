//
//  URLRequestable.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

// MARK: - URLRequestable

public protocol URLRequestable: BaseURLHaving {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Encodable? { get }
    var headers: [String: String]? { get }
}

// MARK: - Default implementations

extension URLRequestable {
    public var parameters: Encodable? {
        nil
    }

    public var headers: [String: String]? {
        nil
    }
}

