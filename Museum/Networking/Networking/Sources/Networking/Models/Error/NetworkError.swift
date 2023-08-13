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

// MARK: - NetworkError + Error message

extension NetworkError {
    private enum Constant {
        static let genericErrorDescription = "We could not complete your request"
    }

    public var message: String {
        switch self {
        case .noHTTPResponse(let executionErrorDetails),
                .clientError(let executionErrorDetails),
                .serverError(let executionErrorDetails),
                .unknown(let executionErrorDetails),
                .invalidURL(let executionErrorDetails),
                .serialization(let executionErrorDetails),
                .executionError(let executionErrorDetails),
                .noInternetConnection(let executionErrorDetails),
                .requestTimedOut(let executionErrorDetails):
            return executionErrorDetails.message ?? Constant.genericErrorDescription
        case .parse(let message):
            return message ?? Constant.genericErrorDescription
        case .requestCancelled:
            return "Request is Cancelled"
        }
    }
}
