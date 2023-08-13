//
//  MuseumItemDetailInteractorTests.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemDetailInteractorTests: XCTestCase {

    // MARK: - Private variables

    private var sut: MuseumItemDetailInteractor!
    private var service: MuseumItemDetailServiceMock!
    private var presenter: MuseumItemDetailPresenterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        service = .init()
        presenter = .init()
        sut = .init(itemObjectNumber: "Object Number", service: service)
        sut.output = presenter
    }

    override func tearDown() {
        service = nil
        presenter = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_presenter_gets_failure_result_when_interactor_receives_success_from_service() {
        // Given
        let expectation = XCTestExpectation(description: "Expecting Success")
        presenter.gotMuseumItemDetailExpectation = expectation
        service.expectedGetMuseumItemDetailResult = .success(.init(artObject: EntityMaker.makeArtObjectDetail()))
        
        // When
        sut.getItemDetail()

        // Then
        wait(for: [expectation], timeout: 0.5)
    }

    func test_presenter_gets_failure_result_when_interactor_receives_error_from_service() {
        // Given
        let expectation = XCTestExpectation(description: "Expecting Failure")
        presenter.getMuseumItemDetailFailedExpectation = expectation
        service.expectedGetMuseumItemDetailResult = .failure(.requestCancelled)

        // When
        sut.getItemDetail()

        // Then
        wait(for: [expectation], timeout: 0.5)
    }
}
