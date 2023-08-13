//
//  MuseumItemDetailPresenter.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

final class MuseumItemDetailPresenter {

    // MARK: - Private variables

    private weak var view: MuseumItemDetailViewable?
    private let interactor: MuseumItemDetailInteractorInputProtocol
    private let router: MuseumItemDetailRouting

    // MARK: - Initialisers

    init(
        view: MuseumItemDetailViewable,
        interactor: MuseumItemDetailInteractorInputProtocol,
        router: MuseumItemDetailRouting
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MuseumItemDetailPresentation

extension MuseumItemDetailPresenter: MuseumItemDetailPresentation {

}

// MARK: - MuseumItemDetailInteractorOutputProtocol

extension MuseumItemDetailPresenter: MuseumItemDetailInteractorOutputProtocol {
    func gotMuseumItemDetail(_ item: ArtObject) {

    }

    func getMuseumItemDetailFailed(errorMessage: String) {

    }
}
