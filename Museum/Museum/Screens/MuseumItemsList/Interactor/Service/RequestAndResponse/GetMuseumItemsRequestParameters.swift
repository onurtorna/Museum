//
//  GetMuseumItemsRequestParameters.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

struct GetMuseumItemsRequestParameters: Encodable {
    let key: String = Secret.apiKey
    let pageNumber: Int

    enum CodingKeys: String, CodingKey {
        case key
        case pageNumber = "p"
    }
}
