//
//  MuseumItemsListServiceMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import enum Networking.NetworkError
@testable import Museum

final class MuseumItemsListServiceMock: MuseumItemsListServing {
    var expectedGetMuseumItemsResult: Result<GetMuseumItemsResponse, NetworkError>!
    func getMuseumItems(pageNumber: Int) async -> Result<GetMuseumItemsResponse, NetworkError> {
        expectedGetMuseumItemsResult
    }
}
