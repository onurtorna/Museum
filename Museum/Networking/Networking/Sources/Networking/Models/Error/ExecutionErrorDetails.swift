//
//  ExecutionErrorDetails.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

// MARK: - ExecutionErrorDetails

public struct ExecutionErrorDetails {
    public static var generic: Self {
        .init(
            message: "Something went wrong.",
            code: 0,
            errorDescription: nil
        )
    }

    public let message: String?
    public let code: Int
    public let errorDescription: String?
}

// MARK: CustomStringConvertible

extension ExecutionErrorDetails: CustomStringConvertible {
    public var description: String {
        """
        \(Self.self):
        {
            message: \(message ?? ""),
            code: \(code),
            errorDescription: \(errorDescription ?? "")
        }
        """
    }
}

