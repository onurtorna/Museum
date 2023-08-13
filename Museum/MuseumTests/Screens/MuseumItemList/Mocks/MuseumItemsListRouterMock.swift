//
//  MuseumItemsListRouterMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 12.08.2023.
//

import UIKit
@testable import Museum

final class MuseumItemsListRouterMock: MuseumItemsListRouting {
    var viewController: UIViewController?
    var loadingViewController: LoadingViewController = .init()

    private(set) var isShowErrorCalled = false
    func showError(description: String, retryAction: AlertAction) {
        isShowErrorCalled = true
    }

    private(set) var isShowLoadingViewCalled = false
    func showLoadingView() {
        isShowLoadingViewCalled = true
    }

    private(set) var isHideLoadingViewCalled = false
    func hideLoadingView() {
        isHideLoadingViewCalled = true
    }
}
