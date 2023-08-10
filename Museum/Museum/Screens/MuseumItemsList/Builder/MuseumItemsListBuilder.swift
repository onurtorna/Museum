//
//  MuseumItemsListBuilder.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

enum MuseumItemsListBuilder {
    static func build() -> MuseumItemsListViewController {
        let view = MuseumItemsListViewController()
        let interactor = MuseumItemsListInteractor()
        let presenter = MuseumItemsListPresenter(
            view: view,
            interactor: interactor
        )
        interactor.output = presenter
        view.presenter = presenter
        view.title = "Museum Items"
        return view
    }
}
