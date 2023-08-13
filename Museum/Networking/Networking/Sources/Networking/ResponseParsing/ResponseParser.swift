//
//  ResponseParser.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

// MARK: - ResponseParser

enum ResponseParser: ResponseParsing {
    static func parseResponse<T: Decodable>(
        data: Data,
        responseType: T.Type
    ) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()
        do {
            let decodedModel = try decoder.decode(T.self, from: data)
            return .success(decodedModel)
        } catch let error as DecodingError {
            let message = messageForDecodingError(error)
            return .failure(NetworkError.parse(message: message))
        } catch {
            return .failure(NetworkError.parse(message: nil))
        }
    }
}

// MARK: - Helpers

extension ResponseParser {
    private static func messageForDecodingError(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch(let key, let value):
            return "Type mismatch error! \(key), value \(value), error description: \(error.localizedDescription)"
        case .valueNotFound(let key, let value):
            return "Value not found error! \(key), value \(value), error description: \(error.localizedDescription)"
        case .keyNotFound(let key, let value):
            return "Key not found error! \(key), value \(value), error description: \(error.localizedDescription)"
        case .dataCorrupted(let key):
            return "Data corrupted error! \(key), error description: \(error.localizedDescription)"
        default:
            return "Undefined decoding error description: \(error.localizedDescription)"
        }
    }
}

