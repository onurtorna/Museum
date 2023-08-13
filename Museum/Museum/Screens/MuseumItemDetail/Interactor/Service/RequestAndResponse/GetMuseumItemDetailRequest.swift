//
//  GetMuseumItemDetailRequest.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Networking

struct GetMuseumItemDetailRequest: MuseumRequest {
    let method: HTTPMethod = .get
    let path: String
    let parameters: Encodable? = GetMuseumItemDetailRequestParameters()

    init(objectID: String) {
        path = "collection/\(objectID)"
    }
}
