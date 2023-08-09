//
//  GetMuseumItemsRequest.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Networking

struct GetMuseumItemsRequest: MuseumRequest {
    var method: HTTPMethod = .get
    var path: String = "collection"
    var parameters: Encodable?

    init(parameters: GetMuseumItemsRequestParameters) {
        self.parameters = parameters
    }
}
