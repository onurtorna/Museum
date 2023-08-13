//
//  MuseumItemsListInteractorTests.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemsListInteractorTests: XCTestCase {

    // MARK: - Private variables

    private var sut: MuseumItemsListInteractor!
    private var service: MuseumItemsListServiceMock!
    private var presenter: MuseumItemsListPresenterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        service = .init()
        presenter = .init()
        sut = .init(service: service)
        sut.output = presenter
    }

    override func tearDown() {
        presenter = nil
        service = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_output_is_informed_for_success_after_SUT_gets_successful_response() {
        // Given
        let expectation = XCTestExpectation(description: "Output should be informed with success response")
        presenter.gotMuseumItemsExpectation = expectation

        let expectedResponse = GetMuseumItemsResponse(
            count: 10,
            artObjects: EntityMaker.makeArtObjectList(itemCount: 10)
        )
        service.expectedGetMuseumItemsResult = .success(expectedResponse)

        // When
        sut.getMuseumItems(pageNumber: 1)

        // Then
        wait(for: [expectation], timeout: 0.5)
    }

    func test_output_is_informed_for_failure_after_SUT_gets_failed_response() {
        // Given
        let expectation = XCTestExpectation(description: "Output should be informed with failure response")
        presenter.getMuseumItemsFailedExpectation = expectation
        service.expectedGetMuseumItemsResult = .failure(.unknown(.generic))

        // When
        sut.getMuseumItems(pageNumber: 1)

        // Then
        wait(for: [expectation], timeout: 0.5)
    }
}
