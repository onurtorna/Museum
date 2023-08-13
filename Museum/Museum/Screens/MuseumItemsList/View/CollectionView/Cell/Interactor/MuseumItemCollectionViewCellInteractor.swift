//
//  MuseumItemCollectionViewCellInteractor.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import Foundation
import Kingfisher

final class MuseumItemCollectionViewCellInteractor {

    // MARK: Internal variables

    weak var output: MuseumItemCollectionViewCellInteractorOutputProtocol?

    // MARK: Private variables

    private var currentImageDownloadingTask: DownloadTask?

    // MARK: - Lifecycle

    deinit {
        currentImageDownloadingTask?.cancel()
    }
}

// MARK: MuseumItemCollectionViewCellInteractorInputProtocol

extension MuseumItemCollectionViewCellInteractor: MuseumItemCollectionViewCellInteractorInputProtocol {
    func downloadImage(url: URL) {
        currentImageDownloadingTask = KingfisherManager.shared.retrieveImage(
            with: url,
            completionHandler: { result in
                Task {
                    switch result {
                    case .success(let response):
                        await self.output?.didReceiveImage(image: response.image)
                    case .failure:
                        await self.output?.didFailImage()
                    }
                }
            }
        )
    }
}
