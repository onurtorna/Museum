//
//  MuseumItemDetailPresenterTests.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemDetailPresenterTests: XCTestCase {

    // MARK: - Private variables

    private var sut: MuseumItemDetailPresenter!
    private var view: MuseumItemDetailViewMock!
    private var interactor: MuseumItemDetailInteractorMock!
    private var router: MuseumItemDetailRouterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        sut = .init(
            view: view,
            interactor: interactor,
            router: router
        )
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_viewDidLoad_fetches_item_detail() {
        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(router.isShowLoadingViewCalled)
        XCTAssert(interactor.isGetItemDetailCalled)
    }

    @MainActor
    func test_view_configuration_after_SUT_gets_item_detail() {
        // Given
        let webImage = EntityMaker.makeImageEntity(
            url: .init(string: "www.rijksmuseum.nl")!,
            width: 150,
            height: 300
        )
        let artObjectDetail = EntityMaker.makeArtObjectDetail(
            longTitle: "Long Title",
            description: "Description",
            webImage: webImage
        )

        // When
        sut.gotMuseumItemDetail(artObjectDetail)

        // Then
        XCTAssert(router.isHideLoadingViewCalled)
        XCTAssertEqual(view.setItemParameters?.title, "Long Title")
        XCTAssertEqual(view.setItemParameters?.description, "Description")
        XCTAssertEqual(view.setItemImageURLParameter, .init(string: "www.rijksmuseum.nl"))
        XCTAssertEqual(view.setImageViewHeightToWeightRatioParameter, 300 / 150)
    }

    @MainActor
    func test_router_shows_error_when_SUT_gets_error_from_item_detail() {
        // When
        sut.getMuseumItemDetailFailed(errorMessage: "Sample Error Message")

        // Then
        XCTAssert(router.isShowErrorCalled)
        XCTAssert(router.isHideLoadingViewCalled)
    }
}
