//
//  MuseumItemsListRouter.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

final class MuseumItemsListRouter {

    // MARK: - Internal variables

    private(set) weak var viewController: UIViewController?
    let loadingViewController = LoadingViewController()

    // MARK: - Initialisers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - MuseumItemsListRouting

extension MuseumItemsListRouter: MuseumItemsListRouting {
    func navigateToItemDetail(objectNumber: String) {
        let nextViewController = MuseumItemDetailBuilder.build(objectNumber: objectNumber)
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }

    func showError(description: String, retryAction: AlertAction) {
        let errorAlertViewController = AlertFactory.makeErrorAlert(message: description, retryActionHandler: retryAction)
        viewController?.present(errorAlertViewController, animated: true)
    }
}
