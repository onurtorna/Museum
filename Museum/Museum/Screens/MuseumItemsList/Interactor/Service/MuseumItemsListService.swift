//
//  MuseumItemsListService.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Networking

final class MuseumItemsListService: MuseumItemsListServing {

    // MARK: - Private variables

    private let networking: NetworkProviding

    // MARK: - Initialiser

    init(networking: NetworkProviding = Networking()) {
        self.networking = networking
    }

    // MARK: - Internal function

    func getMuseumItems() async -> Result<GetMuseumItemsResponse, NetworkError> {
        let parameters = GetMuseumItemsRequestParameters()
        let request = GetMuseumItemsRequest(parameters: parameters)
        return await networking.request(
            requestable: request,
            responseType: GetMuseumItemsResponse.self
        )
    }
}
