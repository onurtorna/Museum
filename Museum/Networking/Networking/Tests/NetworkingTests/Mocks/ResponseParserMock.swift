//
//  ResponseParserMock.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import XCTest
@testable import Networking

final class ResponseParserMock: ResponseParsing {
    static var invokedParseSuccessfulResponse = false
    static var invokedParseSuccessfulResponseCount = 0

    static var shouldParsingSuccessfulResponseSucceed = true

    static func parseResponse<T: Decodable>(
        data _: Data,
        responseType _: T.Type
    ) -> Result<T, NetworkError> {
        invokedParseSuccessfulResponse = true
        invokedParseSuccessfulResponseCount += 1

        if shouldParsingSuccessfulResponseSucceed,
           let response = TestModel(testOne: "test", testTwo: "test") as? T {
            return .success(response)
        } else {
            return .failure(.unknown(.generic))
        }
    }


    static func reset() {
        invokedParseSuccessfulResponse = false
        invokedParseSuccessfulResponseCount = 0
        shouldParsingSuccessfulResponseSucceed = true
    }
}

