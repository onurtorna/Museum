//
//  MuseumItemDetailService.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Networking

final class MuseumItemDetailService: MuseumItemDetailServing {

    // MARK: - Private variables

    private let networking: NetworkProviding

    // MARK: - Initialiser

    init(networking: NetworkProviding = Networking()) {
        self.networking = networking
    }

    // MARK: - Internal function

    func getMuseumItemDetial(objectID: String) async -> Result<GetMuseumItemDetailResponse, NetworkError> {
        let request = GetMuseumItemDetailRequest(objectID: objectID)
        return await networking.request(
            requestable: request,
            responseType: GetMuseumItemDetailResponse.self
        )
    }
}
