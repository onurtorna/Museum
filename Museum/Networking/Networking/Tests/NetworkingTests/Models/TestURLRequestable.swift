//
//  TestURLRequestable.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation
@testable import Networking

struct TestURLRequestable: URLRequestable {
    var baseURL: String
    var method: HTTPMethod
    var path: String
    var parameters: Encodable?
    var headers: [String: String]?
}
