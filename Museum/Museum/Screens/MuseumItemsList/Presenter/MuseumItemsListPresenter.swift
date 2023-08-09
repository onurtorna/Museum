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

    // MARK: - Initialiser

    init(
        view: MuseumItemsListViewable,
        interactor: MuseumItemsListInteractorInputProtocol
    ) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - MuseumItemsListPresentation

extension MuseumItemsListPresenter: MuseumItemsListPresentation {
    func load() {
        interactor.getMuseumItems()
    }
}

// MARK: - MuseumItemsListInteractorOutputProtocol

extension MuseumItemsListPresenter: MuseumItemsListInteractorOutputProtocol {
    @MainActor
    func gotMuseumItems(items: [ArtObject]) {
        // To be implemented
    }

    @MainActor
    func getMuseumItemsFailed(errorMessage: String) {
        // To be implemented
    }
}
