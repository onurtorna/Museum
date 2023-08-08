//
//  TestURLRequestableFactory.swift
//
//
//  Created by Onur Torna on 08.08.2023.
//

import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {

    // MARK: Private variables

    private var sut: Networking!
    private var requestFactory: NetworkURLRequestFactoryMock!
    private var requestExecutor: RequestExecutorMock!
    private var responseParser = ResponseParserMock.self
    private var requestAdapter: RequestAdapterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        requestFactory = NetworkURLRequestFactoryMock()
        requestExecutor = RequestExecutorMock()
        requestAdapter = RequestAdapterMock()
        sut = makeSUT()
    }

    override func tearDown() {
        requestFactory = nil
        requestExecutor = nil
        responseParser.reset()
        requestAdapter = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_making_a_request_calls_the_url_request_factory() async {
        await triggerRequest(for: sut)

        XCTAssertTrue(requestFactory.invokedMakeURLRequest)
    }

    func test_a_request_is_adapted_with_request_adapters() async {
        await triggerRequest(for: sut)

        XCTAssertTrue(requestAdapter.invokedAdapt)
    }

    func test_expected_error_is_returned_when_url_request_factory_throws_an_error() async {
        requestFactory.stubbedMakeURLRequestError = .invalidURL(.generic)

        let result = await triggerRequest(for: sut)

        assertErrorEquality(
            for: result,
            expectedError: .invalidURL(.generic)
        )
    }

    func test_making_a_request_calls_the_request_executor() async {
        await triggerRequest(for: sut)

        XCTAssertTrue(requestExecutor.invokedExecute)
    }

    func test_expected_error_is_returned_when_request_executor_returns_an_error() async {
        requestExecutor.shouldSucceedExecution = false

        let result = await triggerRequest(for: sut)

        assertErrorEquality(
            for: result,
            expectedError: .executionError(makeExecutionErrorDetails())
        )
    }

    func test_expected_error_is_returned_when_request_executor_returns_an_error_with_timed_out_code() async {
        requestExecutor.shouldSucceedExecution = false
        requestExecutor.nsErrorCodeToReturn = NSURLErrorTimedOut

        let result = await triggerRequest(for: sut)

        assertErrorEquality(
            for: result,
            expectedError: .requestTimedOut(makeExecutionErrorDetails())
        )
    }

    func test_expected_error_is_returned_when_request_executor_returns_an_error_with_no_internet_connection_code() async {
        requestExecutor.shouldSucceedExecution = false
        requestExecutor.nsErrorCodeToReturn = NSURLErrorNotConnectedToInternet

        let result = await triggerRequest(for: sut)

        assertErrorEquality(
            for: result,
            expectedError: .noInternetConnection(makeExecutionErrorDetails())
        )
    }

    func test_the_success_response_data_parsing_is_triggered_when_the_request_succeeds() async {
        await triggerRequest(for: sut)

        XCTAssertTrue(responseParser.invokedParseSuccessfulResponse)
    }

    func test_the_success_response_data_parsing_is_not_triggered_when_the_request_fails() async {
        requestExecutor.shouldSucceedExecution = false

        await triggerRequest(for: sut)

        XCTAssertFalse(responseParser.invokedParseSuccessfulResponse)
    }

    func test_the_expected_result_is_returned_when_parsing_succeeds() async {
        let expectedResponseProperty = "test"

        let result = await triggerRequest(for: sut)

        switch result {
        case .success(let response):
            XCTAssertEqual(response.testOne, expectedResponseProperty)
        case .failure:
            XCTFail("The request shouldn't have been failed")
        }
    }

    // MARK: Helpers

    private func makeSUT() -> Networking {
        Networking(
            requestFactory: requestFactory,
            requestExecutor: requestExecutor,
            responseParser: responseParser,
            requestAdapters: [requestAdapter]
        )
    }

    private func makeExecutionErrorDetails() -> ExecutionErrorDetails {
        ExecutionErrorDetails(
            message: "doesnt matter",
            code: 1,
            errorDescription: "test"
        )
    }

    private func assertErrorEquality(
        for result: Result<TestModel, NetworkError>,
        expectedError: NetworkError
    ) {
        switch result {
        case .success:
            XCTFail("The request shouldn't have been succeeded")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }

    private func makeURLRequestable() -> TestURLRequestable {
        TestURLRequestableFactory.makeURLRequestable(
            httpMethod: .get,
            parameters: nil
        )
    }

    private func makeURLRequest() throws -> URLRequest {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        return URLRequest(url: url)
    }

    @discardableResult
    private func triggerRequest(for sut: Networking) async -> Result<TestModel, NetworkError> {
        await sut.request(
            requestable: makeURLRequestable(),
            responseType: TestModel.self
        )
    }
}
