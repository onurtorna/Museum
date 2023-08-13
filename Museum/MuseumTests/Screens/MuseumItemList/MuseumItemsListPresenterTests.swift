//
//  MuseumItemsListPresenterTests.swift
//  MuseumTests
//
//  Created by Onur Torna on 12.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemsListPresenterTests: XCTestCase {

    // MARK: - Private variables

    private var sut: MuseumItemsListPresenter!
    private var paginationInfo: Pagination!
    private var view: MuseumItemsListViewMock!
    private var interactor: MuseumItemsListInteractorMock!
    private var router: MuseumItemsListRouterMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_items_are_fetched_with_loading_after_SUT_calls_load() {
        // Given
        makeSUT()

        // When
        sut.load()

        // Then
        XCTAssert(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(interactor.getMuseumItemsParameter, 1)
        XCTAssert(router.isShowLoadingViewCalled)
    }

    func test_interactor_fetching_when_SUT_calls_fetchMuseumItems() {
        // Given
        makeSUT()

        // When
        sut.fetchMuseumItems(showLoading: true)

        // Then
        XCTAssert(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(interactor.getMuseumItemsParameter, 1)
        XCTAssert(router.isShowLoadingViewCalled)
    }

    func test_loading_view_is_not_shown_when_SUT_calls_fetchMuseumItems_without_showLoading() {
        // Given
        makeSUT()

        // When
        sut.fetchMuseumItems(showLoading: false)

        // Then
        XCTAssertFalse(router.isShowLoadingViewCalled)
        XCTAssert(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(interactor.getMuseumItemsParameter, 1)
    }

    @MainActor
    func test_pagination_and_view_updates_after_SUT_calls_gotMuseumItems() {
        // Given
        makeSUT()
        let fetchedItems = EntityMaker.makeArtObjectList(itemCount: 10)

        // When
        sut.gotMuseumItems(items: fetchedItems, totalItemCount: 100)

        // Then
        XCTAssert(router.isHideLoadingViewCalled)
        XCTAssertEqual(
            view.applySnapshotParameters,
            fetchedItems
        )
        XCTAssertFalse(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(paginationInfo.currentPage, 2)
        XCTAssertEqual(paginationInfo.shownItems, 10)
        XCTAssertEqual(paginationInfo.totalItems, 100)
    }

    @MainActor
    func test_pagination_and_view_updates_after_SUT_calls_getMuseumItemsFailed_when_pagination_is_NOT_active() {
        // Given
        let paginationInfo = Pagination()
        paginationInfo.isPaginationActive = false
        makeSUT(paginationInfo: paginationInfo)

        // When
        sut.getMuseumItemsFailed(errorMessage: "Sample Error Message")

        // Then
        XCTAssert(router.isShowErrorCalled)
        XCTAssert(router.isHideLoadingViewCalled)
        XCTAssert(view.isShowRefreshButtonCalled)
        XCTAssertFalse(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(paginationInfo.currentPage, 1)
    }

    @MainActor
    func test_pagination_and_view_updates_after_SUT_calls_getMuseumItemsFailed_when_pagination_is_active() {
        // Given
        let paginationInfo = Pagination()
        paginationInfo.isPaginationActive = true
        makeSUT(paginationInfo: paginationInfo)

        // When
        sut.getMuseumItemsFailed(errorMessage: "Sample Error Message")

        // Then
        XCTAssertFalse(router.isShowErrorCalled)
        XCTAssertFalse(view.isShowRefreshButtonCalled)
        XCTAssert(router.isHideLoadingViewCalled)
        XCTAssertFalse(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(paginationInfo.currentPage, 1)
    }

    func test_pagination_loads_more_when_SUT_calls_paginationRequested_when_pagination_canLoadMore() {
        // Given
        let paginationInfo = Pagination()
        paginationInfo.setTotalItemsCount(100) // Can load more
        paginationInfo.isActivelyFetchingItems = false
        makeSUT(paginationInfo: paginationInfo)

        // When
        sut.paginationRequested()

        // Then
        XCTAssert(paginationInfo.isPaginationActive)
        XCTAssert(paginationInfo.isActivelyFetchingItems)
        XCTAssertEqual(interactor.getMuseumItemsParameter, 1)
        XCTAssertFalse(router.isShowLoadingViewCalled)
    }

    func test_pagination_does_NOT_load_more_when_SUT_calls_paginationRequested_when_pagination_can_NOT_load_more() {
        // Given
        let paginationInfo = Pagination()
        paginationInfo.addShownItems(count: 100)
        paginationInfo.setTotalItemsCount(100) // Can NOT load more
        paginationInfo.isActivelyFetchingItems = false
        makeSUT(paginationInfo: paginationInfo)

        // When
        sut.paginationRequested()

        // Then
        XCTAssertFalse(paginationInfo.isPaginationActive)
        XCTAssertFalse(paginationInfo.isActivelyFetchingItems)
    }

    func test_pagination_does_NOT_load_more_when_SUT_calls_paginationRequested_when_pagination_isActivelyFetchingItems() {
        // Given
        let paginationInfo = Pagination()
        paginationInfo.setTotalItemsCount(100) // Can load more
        paginationInfo.isActivelyFetchingItems = true
        makeSUT(paginationInfo: paginationInfo)

        // When
        sut.paginationRequested()

        // Then
        XCTAssertFalse(paginationInfo.isPaginationActive)
    }
}

// MARK: - Helpers

extension MuseumItemsListPresenterTests {
    private func makeSUT(paginationInfo: Pagination = .init()) {
        self.paginationInfo = paginationInfo
        sut = .init(
            paginationInfo: self.paginationInfo,
            view: view,
            interactor: interactor,
            router: router
        )
    }
}
