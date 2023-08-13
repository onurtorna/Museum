//
//  MuseumItemDetailRouter.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import UIKit

final class MuseumItemDetailRouter: MuseumItemDetailRouting {

    // MARK: - Internal variables

    private(set) weak var viewController: UIViewController?
    let loadingViewController = LoadingViewController()

    // MARK: - Initialisers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
