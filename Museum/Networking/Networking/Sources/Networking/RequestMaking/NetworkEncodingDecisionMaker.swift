//
//  NetworkEncodingDecisionMaker.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

enum NetworkEncodingDecisionMaker {
    static func encodingType(for method: HTTPMethod) -> NetworkEncoding {
        switch method {
        case .get, .delete:
            return .urlEncoding
        case .post, .put, .patch:
            return .jsonEncoding
        }
    }
}
