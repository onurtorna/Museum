//
//  RequestExecutorMock.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import XCTest
@testable import Networking

final class RequestExecutorMock: RequestExecuting {

    // MARK: Internal

    var invokedSessionSetter = false
    var invokedSessionSetterCount = 0
    var invokedSession: URLSession?
    var invokedSessionList = [URLSession]()
    var invokedSessionGetter = false
    var invokedSessionGetterCount = 0
    var stubbedSession = URLSession(configuration: URLSessionConfiguration.default)

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (request: URLRequest, Void)?
    var invokedExecuteParametersList = [(request: URLRequest, Void)]()

    var shouldSucceedExecution = true
    var nsErrorCodeToReturn = 1
    var requestResponseCode = 200

    var session: URLSession {
        get {
            invokedSessionGetter = true
            invokedSessionGetterCount += 1
            return stubbedSession
        }
        set {
            invokedSessionSetter = true
            invokedSessionSetterCount += 1
            invokedSession = newValue
            invokedSessionList.append(newValue)
        }
    }

    func execute(_ request: URLRequest) -> Result<RequestSuccessModel, Error> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (request, ())
        invokedExecuteParametersList.append((request, ()))

        if shouldSucceedExecution {
            return .success(RequestSuccessModel(data: Data(), response: httpURLResponse))
        } else {
            return .failure(NSError(domain: "test_domain", code: nsErrorCodeToReturn))
        }
    }

    // MARK: Private

    private let testURL = URL(string: "www.test.com")!
    private let testHTTPVersion = "HTTP/1.1"

    private var httpURLResponse: HTTPURLResponse {
        HTTPURLResponse(
            url: testURL,
            statusCode: requestResponseCode,
            httpVersion: testHTTPVersion,
            headerFields: nil
        )!
    }

}

// swiftlint:enable identifier_name force_unwrapping

