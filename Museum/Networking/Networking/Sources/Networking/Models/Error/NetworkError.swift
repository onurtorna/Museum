//
//  NetworkError.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

public enum NetworkError: Error {
    case noHTTPResponse(ExecutionErrorDetails)
    case parse(message: String?)
    case clientError(ExecutionErrorDetails)
    case serverError(ExecutionErrorDetails)
    case unknown(ExecutionErrorDetails)
    case invalidURL(ExecutionErrorDetails)
    case serialization(ExecutionErrorDetails)
    case executionError(ExecutionErrorDetails)
    case noInternetConnection(ExecutionErrorDetails)
    case requestTimedOut(ExecutionErrorDetails)
    case requestCancelled
}
