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
    func viewDidLoad() {
        router.showLoadingView()
        interactor.getItemDetail()
    }
}

// MARK: - MuseumItemDetailInteractorOutputProtocol

extension MuseumItemDetailPresenter: MuseumItemDetailInteractorOutputProtocol {
    func gotMuseumItemDetail(_ item: ArtObjectDetail) {
        router.hideLoadingView()
        view?.setItem(title: item.longTitle, description: item.description)

        let imageEntity = item.webImage
        let heightToWidthRatio = CGFloat(imageEntity.height) / CGFloat(imageEntity.width)
        view?.setItemImageURL(imageEntity.url)
        view?.setImageViewHeightToWeightRatio(heightToWidthRatio)
    }

    func getMuseumItemDetailFailed(errorMessage: String) {
        router.hideLoadingView()
        router.showError(description: errorMessage) { [weak self] in
            self?.viewDidLoad()
        }
    }
}
