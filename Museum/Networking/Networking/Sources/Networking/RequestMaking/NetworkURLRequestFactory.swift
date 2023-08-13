//
//  NetworkURLRequestFactory.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

// MARK: - NetworkURLRequestFactory

struct NetworkURLRequestFactory: NetworkURLRequestMaking {

    private let jsonEncoder = JSONEncoder()

    // MARK: - Internal functions
    func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest {
        guard var url = URL(string: requestable.baseURL) else {
            throw NetworkError.invalidURL(.generic)
        }

        url.appendPathComponent(requestable.path)

        var encodedParameters: Data?
        if let parameters = requestable.parameters {
            guard let encoded = try? jsonEncoder.encode(parameters) else {
                throw NetworkError.serialization(.generic)
            }
            encodedParameters = encoded
        }

        let encodingType = NetworkEncodingDecisionMaker.encodingType(for: requestable.method)

        switch encodingType {
        case .urlEncoding:
            return try urlRequestForURLEncoding(
                url: url,
                parameters: encodedParameters,
                headers: requestable.headers,
                httpMethod: requestable.method
            )
        case .jsonEncoding:
            return urlRequestForJSONEncoding(
                url: url,
                parameters: encodedParameters,
                headers: requestable.headers,
                httpMethod: requestable.method
            )
        }
    }
}

// MARK: - Helpers
extension NetworkURLRequestFactory {
    private func urlRequestForURLEncoding(
        url: URL,
        parameters: Data?,
        headers: [String: String]?,
        httpMethod: HTTPMethod
    ) throws -> URLRequest {
        if let parameters = parameters,
           let queryParameters = try? JSONSerialization.jsonObject(
               with: parameters,
               options: .fragmentsAllowed
           ) as? [String: Any],
           !queryParameters.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw NetworkError.invalidURL(.generic)
            }

            components.queryItems = queryParameters.map {
                // Cast the value as a `Bool` if it can be cast.
                // It is needed because JSONSerialization converts `Bool` to `CFBoolean`,
                // which acts as an `Int` when directly used with String(describing:)
                // Reference: https://forums.swift.org/t/jsonserialization-turns-bool-value-to-nsnumber/31909
                // Also, we do not want Int to be sent as boolean
                // So we need to check the type of a boolean with a boolean (true)
                // Reference:
                // https://stackoverflow.com/questions/49641102#49641315
                if type(of: $0.value) == type(of: NSNumber(value: true)),
                   let value = $0.value as? Bool {
                    return URLQueryItem(name: $0.key, value: "\(value)")
                }
                return URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
            guard let finalURL = components.url else {
                throw NetworkError.invalidURL(.generic)
            }
            var urlRequest = URLRequest(url: finalURL)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers, for: &urlRequest)
            return urlRequest
        } else {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            addHeaders(headers, for: &urlRequest)
            return urlRequest
        }
    }

    private func urlRequestForJSONEncoding(
        url: URL,
        parameters: Data?,
        headers: [String: String]?,
        httpMethod: HTTPMethod
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = parameters
        urlRequest.httpMethod = httpMethod.rawValue
        addHeaders(headers, for: &urlRequest)
        return urlRequest
    }

    private func addHeaders(_ headers: [String: String]?, for request: inout URLRequest) {
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
