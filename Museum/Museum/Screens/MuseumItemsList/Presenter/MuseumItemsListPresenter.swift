//
//  MuseumItemsListPresenter.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

// MARK: - MuseumItemsListPresenter

final class MuseumItemsListPresenter {

    // MARK: - Private variables

    private weak var view: MuseumItemsListViewable?
    private let interactor: MuseumItemsListInteractorInputProtocol
    private let router: MuseumItemsListRouting

    private var paginationInfo: Pagination

    // MARK: - Initialiser

    init(
        paginationInfo: Pagination = Pagination(),
        view: MuseumItemsListViewable,
        interactor: MuseumItemsListInteractorInputProtocol,
        router: MuseumItemsListRouting
    ) {
        self.paginationInfo = paginationInfo
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MuseumItemsListPresentation

extension MuseumItemsListPresenter: MuseumItemsListPresentation {
    func load() {
        fetchMuseumItems(showLoading: true)
    }

    func fetchMuseumItems(showLoading: Bool) {
        if showLoading {
            router.showLoadingView()
        }
        paginationInfo.isActivelyFetchingItems = true
        interactor.getMuseumItems(pageNumber: paginationInfo.currentPage)
    }
}

// MARK: - MuseumItemsListInteractorOutputProtocol

extension MuseumItemsListPresenter: MuseumItemsListInteractorOutputProtocol {
    @MainActor
    func gotMuseumItems(items: [ArtObject], totalItemCount: Int) {
        router.hideLoadingView()
        paginationInfo.isActivelyFetchingItems = false
        paginationInfo.incrementPageNumber()
        paginationInfo.setTotalItemsCount(totalItemCount)
        paginationInfo.addShownItems(count: items.count)
        view?.hideRefreshButton()
        view?.applySnapshot(items: items)
    }

    @MainActor
    func getMuseumItemsFailed(errorMessage: String) {
        router.hideLoadingView()
        paginationInfo.isActivelyFetchingItems = false

        // Do not show error if there are items shown in the screen
        // Fail silently
        guard !paginationInfo.isPaginationActive else { return }
        view?.showRefreshButton()
        router.showError(description: errorMessage) { [weak self] in
            self?.fetchMuseumItems(showLoading: true)
        }
    }
}

// MARK: - MuseumItemsListCollectionViewDataSourceDelegate

extension MuseumItemsListPresenter {
    func paginationRequested() {
        guard !paginationInfo.isActivelyFetchingItems,
              paginationInfo.canLoadMore else {
            return
        }
        paginationInfo.isPaginationActive = true
        fetchMuseumItems(showLoading: false)
    }
}
