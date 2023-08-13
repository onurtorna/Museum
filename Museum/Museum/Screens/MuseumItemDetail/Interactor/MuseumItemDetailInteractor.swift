//
//  MuseumItemDetailInteractor.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

final class MuseumItemDetailInteractor {

    // MARK: - Internal variables

    weak var output: MuseumItemDetailInteractorOutputProtocol?

    // MARK: - Private variables

    private let itemObjectNumber: String
    private let service: MuseumItemDetailServing

    // MARK: - Initialisers

    init(
        itemObjectNumber: String,
        service: MuseumItemDetailServing = MuseumItemDetailService()
    ) {
        self.itemObjectNumber = itemObjectNumber
        self.service = service
    }
}

// MARK: - MuseumItemDetailInteractorInputProtocol

extension MuseumItemDetailInteractor: MuseumItemDetailInteractorInputProtocol {
    func getItemDetail() {
        Task {
            let result = await service.getMuseumItemDetial(objectID: itemObjectNumber)
            switch result {
            case .success(let response):
                await output?.gotMuseumItemDetail(response.artObject)

            case .failure(let error):
                await output?.getMuseumItemDetailFailed(errorMessage: error.message)
            }
        }
    }
}
