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

    // MARK: - Initialisers

    init(itemObjectNumber: String) {
        self.itemObjectNumber = itemObjectNumber
    }
}

// MARK: - MuseumItemDetailInteractorInputProtocol

extension MuseumItemDetailInteractor: MuseumItemDetailInteractorInputProtocol {

}
