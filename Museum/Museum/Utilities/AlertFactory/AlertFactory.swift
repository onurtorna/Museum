//
//  AlertFactory.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

// MARK: - Typealiases

typealias AlertAction = (() -> Void)?

// MARK: - AlertFactory

/// Creates alert view controllers
enum AlertFactory {

    // MARK: - Internal functions

    /// Creates an alert with only "OK" button as action
    static func makeOkAlert(
        title: String,
        message: String,
        okActionHandler: AlertAction = nil
    ) -> UIAlertController {
        let alertController = makeAlert(title: title, message: message)
        let okAction = makeAction(title: Constant.okButtonTitle, action: okActionHandler)
        alertController.addAction(okAction)
        return alertController
    }

    /// Creates error alert with specific title and OK action
    static func makeErrorAlert(
        message: String,
        okActionHandler: AlertAction = nil
    ) -> UIAlertController {
        let alertController = makeAlert(title: Constant.errorAlertTitle, message: message)
        let okAction = makeAction(title: Constant.okButtonTitle, action: okActionHandler)
        alertController.addAction(okAction)
        return alertController
    }

    /// Creates error alert with specific title, Retry and OK buttons
    static func makeErrorAlert(
        message: String,
        retryActionHandler: AlertAction,
        okActionHandler: AlertAction = nil
    ) -> UIAlertController {
        let alertController = makeAlert(title: Constant.errorAlertTitle, message: message)
        let okAction = makeAction(title: Constant.okButtonTitle, action: okActionHandler)
        alertController.addAction(okAction)
        let retryAction = makeAction(title: Constant.retryButtonTitle, action: retryActionHandler)
        alertController.addAction(retryAction)
        return alertController
    }
}

// MARK: - Helpers

extension AlertFactory {
    private static func makeAlert(title: String, message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    private static func makeAction(title: String, action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { _ in
            action?()
        }
    }
}

// MARK: - Constants

extension AlertFactory {
    private enum Constant {
        static let errorAlertTitle = "Error!"
        static let okButtonTitle = "OK"
        static let retryButtonTitle = "Retry"
    }


}
