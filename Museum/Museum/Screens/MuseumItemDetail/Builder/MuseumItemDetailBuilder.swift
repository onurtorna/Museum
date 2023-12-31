//
//  MuseumItemDetailBuilder.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

enum MuseumItemDetailBuilder {
    static func build(objectNumber: String) -> MuseumItemDetailViewController {
        let view = MuseumItemDetailViewController()
        let interactor = MuseumItemDetailInteractor(itemObjectNumber: objectNumber)
        let router = MuseumItemDetailRouter(viewController: view)
        let presenter = MuseumItemDetailPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        interactor.output = presenter
        view.presenter = presenter
        view.title = "Item Detail"
        return view
    }
}
