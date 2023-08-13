//
//  ErrorShowing.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import Foundation

protocol ErrorShowing {
    func showError(description: String, retryAction: AlertAction)
}

// MARK: - Router + Default implementation

extension ErrorShowing where Self: Router {
    func showError(description: String, retryAction: AlertAction) {
        let errorAlertViewController = AlertFactory.makeErrorAlert(message: description, retryActionHandler: retryAction)
        viewController?.present(errorAlertViewController, animated: true)
    }
}
