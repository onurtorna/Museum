//
//  Networking.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

// MARK: - Networking

public final class Networking: NetworkProviding {

    // MARK: Lifecycle

    // MARK: - Public initialiser

    /// Public initialiser for networking class. Allows request customisation and adaptation
    /// - Parameter requestAdapters: An array of adapters to adapt a request before executing it.
    ///   For example an adapter can be used to provide default headers for every request.
    public convenience init(
        requestAdapters: [RequestAdapting] = []
    ) {
        self.init(
            requestFactory: NetworkURLRequestFactory(),
            responseParser: ResponseParser.self,
            requestAdapters: requestAdapters
        )
    }

    // MARK: - Internal initialiser

    /// Common initialiser for networking class. If parameters are not given,
    /// Apart from mocking, default values for requestExecutor, fileUploader and fileDownloader should be sufficient
    /// - Parameters:
    ///   - requestFactory: Creates URL request from URLRequestable protocol.
    ///   - requestExecutor: Performs network call.
    ///   - responseParser: Parses the result after getting the response from the backend.
    ///   - requestAdapters: An array of adapters to adapt a request before executing it.
    ///   For example an adapter can be used to provide default headers for every request.
    init(
        requestFactory: NetworkURLRequestMaking,
        requestExecutor: RequestExecuting? = nil,
        responseParser: ResponseParsing.Type,
        requestAdapters: [RequestAdapting] = []
    ) {
        session = .init(
            configuration: SessionConfigurationProvider.sessionConfiguration
        )

        self.requestFactory = requestFactory
        self.responseParser = responseParser

        // If requestExecutor is not injected (for test purposes),
        // Use default internal RequestExecutor with the same session as we recently created
        self.requestExecutor = requestExecutor ?? RequestExecutor(
            session: session
        )

        self.requestAdapters = requestAdapters
    }

    deinit {
        // Invalidation of the session is needed to release it properly.
        // Otherwise it may be retained for longer than needed
        // due to some internal caching, retaining its delegate with it.
        session.finishTasksAndInvalidate()
    }

    // MARK: - Private variables

    private let requestFactory: NetworkURLRequestMaking
    private let requestExecutor: RequestExecuting
    private let responseParser: ResponseParsing.Type
    private let session: URLSession

    private let requestAdapters: [RequestAdapting]

    // MARK: - Public functions

    /// A method to make a network request
    /// - Parameters:
    ///    - requestable: A model conforming to `URLRequestable` to define the details of a request
    ///    - responseType: An expected type to parse the result of the request for
    /// - Returns: A `Swift` `Result` type with `Decodable` for the success case,
    /// - Note: You must switch to `@MainActor` from your calling Task to update UI components.
    public func request<T: Decodable, V: URLRequestable>(
        requestable: V,
        responseType: T.Type
    ) async -> Result<T, NetworkError> {
        do {
            let urlRequest = try requestFactory.makeURLRequest(with: requestable)
            let adaptedRequest = adaptRequest(request: urlRequest)
            let result = await requestExecutor.execute(adaptedRequest)
            switch result {
            case .success(let successModel):
                return didSucceedExecutingRequest(
                    with: successModel,
                    responseType: responseType
                )
            case .failure(let error):
                let error = didFailExecutingRequest(error: error)
                return .failure(error)
            }
        } catch let networkError as NetworkError {
            return .failure(networkError)
        } catch {
            let error = NetworkError.unknown(.generic)
            return .failure(error)
        }
    }
}

// MARK: - Parsing Helpers

extension Networking {
    private func didSucceedExecutingRequest<T: Decodable>(
        with successModel: RequestSuccessModel,
        responseType: T.Type
    ) -> Result<T, NetworkError> {
        let httpResponseStatus = successModel.response.responseStatus
        switch httpResponseStatus {
        case .success:
            return didReceiveSuccessStatusCode(
                with: successModel,
                responseType: responseType
            )
        case .failure(let error):
            return .failure(error)
        }
    }

    private func didReceiveSuccessStatusCode<T: Decodable>(
        with successModel: RequestSuccessModel,
        responseType: T.Type
    ) -> Result<T, NetworkError> {
        let parsingResult = responseParser.parseResponse(data: successModel.data, responseType: responseType)
        return parsingResult
    }

    private func adaptRequest(request: URLRequest) -> URLRequest {
        var adaptedRequest = request
        requestAdapters.forEach {
            adaptedRequest = $0.adapt(request: adaptedRequest)
        }
        return adaptedRequest
    }
}

// MARK: - Error Handling

extension Networking {
    private func didFailExecutingRequest(error: Error) -> NetworkError {
        let nsError = error as NSError
        if nsError.code == NSURLErrorTimedOut {
            return .requestTimedOut(ExecutionErrorDetails(
                message: "Request Timed out..",
                code: nsError.code,
                errorDescription: nsError.localizedDescription
            ))
        } else if nsError.code == NSURLErrorNotConnectedToInternet {
            return .noInternetConnection(ExecutionErrorDetails(
                message: "No internet connection!",
                code: nsError.code,
                errorDescription: nsError.localizedDescription
            ))
        } else if nsError.code == NSURLErrorCancelled {
            return .requestCancelled
        } else {
            return .executionError(ExecutionErrorDetails(
                message: nil,
                code: nsError.code,
                errorDescription: nsError.localizedDescription
            ))
        }
    }
}
