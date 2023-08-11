//
//  MuseumItemsListInteractor.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

// MARK: - MuseumItemsListInteractor

final class MuseumItemsListInteractor {

    // MARK: - Internal variables

    weak var output: MuseumItemsListInteractorOutputProtocol?

    // MARK: - Private variables

    private let service: MuseumItemsListServing

    // MARK: - Initialiser

    init(
        service: MuseumItemsListServing = MuseumItemsListService()
    ) {
        self.service = service
    }
}

// MARK: - MuseumItemsListInteractorInputProtocol

extension MuseumItemsListInteractor: MuseumItemsListInteractorInputProtocol {
    func getMuseumItems(pageNumber: Int) {
        Task {
            let result = await service.getMuseumItems(pageNumber: pageNumber)
            switch result {
            case .success(let response):
                await output?.gotMuseumItems(items: response.artObjects, totalItemCount: response.count)

            case .failure(let error):
                await output?.getMuseumItemsFailed(errorMessage: error.localizedDescription)
            }
        }
    }
}
