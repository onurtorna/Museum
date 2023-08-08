//
//  NetworkError+Equatable.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation
@testable import Networking

// An extension to check error equality
// Since this is only used for tests and we don't care about the associated values
// They are ignored when the equality decision is done
// It can be extended to include the associated values later on, if needed.
extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noHTTPResponse, .noHTTPResponse),
             (.parse, .parse),
             (.clientError, .clientError),
             (.serverError, .serverError),
             (.unknown, .unknown),
             (.invalidURL, .invalidURL),
             (.serialization, .serialization),
             (.requestTimedOut, .requestTimedOut),
             (.noInternetConnection, .noInternetConnection),
             (.executionError, .executionError):
            return true
        default:
            return false
        }
    }
}

