//
//  LoadingViewController.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

final class LoadingViewController: UIViewController {

    // MARK: - Private variables

    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    // MARK: - Initialisers

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension LoadingViewController {
    private func setUp() {
        view.addSubview(activityIndicatorView)
        view.backgroundColor = .clear.withAlphaComponent(0.3)

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
