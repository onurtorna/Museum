//
//  MuseumItemsListInteractorMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 12.08.2023.
//

@testable import Museum

final class MuseumItemsListInteractorMock: MuseumItemsListInteractorInputProtocol {
    var getMuseumItemsParameter: Int?
    func getMuseumItems(pageNumber: Int) {
        getMuseumItemsParameter = pageNumber
    }
}
