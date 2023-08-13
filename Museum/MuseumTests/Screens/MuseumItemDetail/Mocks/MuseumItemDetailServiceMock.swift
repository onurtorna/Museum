//
//  MuseumItemDetailServiceMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import Networking
@testable import Museum

final class MuseumItemDetailServiceMock: MuseumItemDetailServing {
    var expectedGetMuseumItemDetailResult: Result<GetMuseumItemDetailResponse, NetworkError>!
    func getMuseumItemDetail(objectID: String) async -> Result<GetMuseumItemDetailResponse, NetworkError> {
        expectedGetMuseumItemDetailResult
    }
}
