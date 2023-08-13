//
//  LoadingViewShowing.swift
//  Museum
//
//  Created by Onur Torna on 12.08.2023.
//

protocol LoadingViewShowing {
    var loadingViewController: LoadingViewController { get }
    func showLoadingView()
    func hideLoadingView()
}

// MARK: - Router + Default implementation

extension LoadingViewShowing where Self: Router {
    func showLoadingView() {
        guard loadingViewController.presentingViewController == nil else { return }
        viewController?.present(loadingViewController, animated: false)
    }

    func hideLoadingView() {
        loadingViewController.dismiss(animated: false)
    }
}
