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

    // MARK: Pagination related variables

    private var shownItems = 0
    private var totalItems = 0
    private var currentPage = 1
    // Prevents pagination to fetch again while actively fetching items
    private var isActivelyFetchingItems = false

    // MARK: - Initialiser

    init(
        view: MuseumItemsListViewable,
        interactor: MuseumItemsListInteractorInputProtocol,
        router: MuseumItemsListRouting
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MuseumItemsListPresentation

extension MuseumItemsListPresenter: MuseumItemsListPresentation {
    func load() {
        // TODO: Show loading view
        isActivelyFetchingItems = true
        interactor.getMuseumItems(pageNumber: currentPage)
    }
}

// MARK: - MuseumItemsListInteractorOutputProtocol

extension MuseumItemsListPresenter: MuseumItemsListInteractorOutputProtocol {
    @MainActor
    func gotMuseumItems(items: [ArtObject], totalItemCount: Int) {
        // TODO: Hide loading view
        isActivelyFetchingItems = false
        totalItems = totalItemCount
        shownItems += items.count
        view?.applySnapshot(items: items)
    }

    @MainActor
    func getMuseumItemsFailed(errorMessage: String) {
        // TODO: Hide loading view
        isActivelyFetchingItems = false
        // To be implemented
    }
}

// MARK: - MuseumItemsListCollectionViewDataSourceDelegate

extension MuseumItemsListPresenter {
    func paginationRequested() {
        guard !isActivelyFetchingItems,
              shownItems < totalItems else {
            return
        }
        isActivelyFetchingItems = true
        currentPage += 1
        interactor.getMuseumItems(pageNumber: currentPage)
    }
}
