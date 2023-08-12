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
