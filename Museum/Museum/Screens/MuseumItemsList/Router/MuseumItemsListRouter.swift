//
//  MuseumItemsListRouter.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

final class MuseumItemsListRouter {

    // MARK: - Private variables

    private weak var viewController: UIViewController?

    // MARK: - Initialisers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - MuseumItemsListRouting

extension MuseumItemsListRouter: MuseumItemsListRouting {
    func showError(description: String, retryAction: AlertAction) {
        let errorAlertViewController = AlertFactory.makeErrorAlert(message: description, retryActionHandler: retryAction)
        viewController?.present(errorAlertViewController, animated: true)
    }
}
