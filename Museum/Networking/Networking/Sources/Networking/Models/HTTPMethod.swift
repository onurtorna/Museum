//
//  HTTPMethod.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

public enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
